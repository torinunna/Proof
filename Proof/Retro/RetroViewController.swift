//
//  RetroViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import SnapKit
import UIKit

class RetroViewController: UIViewController {
        
    let calendar = Calendar.current
    var calendarDate = Date()
    var days = [Date]()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        return label
    }()
    
    private lazy var previousWeekButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(previousWeekBtnPressed), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    @objc func previousWeekBtnPressed() {
        calendarDate = calendar.date(byAdding: DateComponents(day: -7), to: calendarDate) ?? Date()
        setMonthView()
    }
    
    private lazy var nextWeekButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.addTarget(self, action: #selector(nextWeekBtnPressed), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    @objc func nextWeekBtnPressed() {
        calendarDate = calendar.date(byAdding: DateComponents(day: +7), to: calendarDate) ?? Date()
        setMonthView()
    }
 
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        tableView.register(RetroListCell.self, forCellReuseIdentifier: RetroListCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpLayout()
        setMonthView()
    }
    
    func setMonthView() {
        days.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: calendarDate)
        let nextsunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextsunday) {
            days.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        titleLabel.text = CalendarHelper().yearString(date: calendarDate) + " " + CalendarHelper().monthString(date: calendarDate)
        collectionView.reloadData()
    }
    
}

//MARK:  - CollectionView Extensions

extension RetroViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
        
        let date = days[indexPath.item]
        cell.dayLabel.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == calendarDate) {
            cell.backgroundColor = UIColor.systemGreen
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        cell.setUp()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        calendarDate = days[indexPath.item]
        collectionView.reloadData()
    }
}

extension RetroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 2) / 8
        let height = width
        
        return CGSize(width: width, height: height)
    }
}
//MARK:  - TableView Extension

extension RetroViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RetroListCell.identifier, for: indexPath) as? RetroListCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setUp()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
}

//MARK:  - Private Extension

private extension RetroViewController {
    
    func setUpNavigationBar() {
        navigationItem.title = "나의 회고"
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addBtnPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addBtnPressed() {
        let vc = AddRetroViewController()
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true)
    }
    
//MARK:  - Layout

    func setUpLayout() {
        
        let weekdayStackView = UIStackView()
        weekdayStackView.spacing = 4.0
        weekdayStackView.distribution = .fillEqually
        
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let label = UILabel()
            label.text = dayOfTheWeek[i]
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 17.0, weight: .medium)
            weekdayStackView.addArrangedSubview(label)
        }
        
        [previousWeekButton, titleLabel, nextWeekButton, weekdayStackView, collectionView, tableView].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 15.0
        let buttonWidth: CGFloat = 25.0
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
        previousWeekButton.snp.makeConstraints {
            $0.trailing.equalTo(titleLabel.snp.leading).offset(-100.0)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        nextWeekButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(100.0)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        weekdayStackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.height.equalTo(50.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.top.equalTo(weekdayStackView.snp.bottom)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.height.equalTo(weekdayStackView.snp.height)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
    }
    
}
