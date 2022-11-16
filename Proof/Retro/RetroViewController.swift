//
//  RetroViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import SnapKit
import UIKit

class RetroViewController: UIViewController {
        
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        return label
    }()
    
    private lazy var nextWeekButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        return button
    }()
    
    private lazy var previousWeekButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        return button
    }()
    
    private lazy var sundayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textColor = .systemRed
        label.textAlignment = .center
        return label
    }()
    
    private lazy var mondayLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tuesdayLabel: UILabel = {
        let label = UILabel()
        label.text = "화"
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var wednesdayLabel: UILabel = {
        let label = UILabel()
        label.text = "수"
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var thursdayLabel: UILabel = {
        let label = UILabel()
        label.text = "목"
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var fridayLabel: UILabel = {
        let label = UILabel()
        label.text = "금"
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var saturdayLabel: UILabel = {
        let label = UILabel()
        label.text = "토"
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var selectedDate = Date()
    private lazy var totalSquares = [Date]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        tableView.register(RetroListCell.self, forCellReuseIdentifier: "RetroListCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpLayout()
        setMonthView()
        previousWeek()
        nextWeek()
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextsunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextsunday) {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " "
        collectionView.reloadData()
    }
    
}

//MARK:  - CollectionView Extensions

extension RetroViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell
        
        let date = totalSquares[indexPath.item]
        
        cell?.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == selectedDate) {
            cell?.backgroundColor = UIColor.systemGreen
        } else {
            cell?.backgroundColor = UIColor.white
        }
        cell?.setUp()
        
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetroListCell", for: indexPath) as? RetroListCell
        cell?.selectionStyle = .none
        cell?.setUp()
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
}

//MARK:  - Private Extension

private extension RetroViewController {
    
    func setUpNavigationBar() {
        navigationItem.title = "Calendar"
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonPressed() {
        let vc = AddRetroViewController()
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true)
    }
    
    func previousWeek() {
        previousWeekButton.addTarget(self, action: #selector(previousWeekPressed), for: .touchUpInside)
    }
    
    @objc func previousWeekPressed() {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setMonthView()
    }
    
    func nextWeek() {
        nextWeekButton.addTarget(self, action: #selector(nextWeekPressed), for: .touchUpInside)
    }
    
    @objc func nextWeekPressed() {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setMonthView()
    }
    
    
//MARK:  - Layout

    func setUpLayout() {
        
        let dayStackView = UIStackView(arrangedSubviews: [sundayLabel, mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel])
        dayStackView.spacing = 4.0
        dayStackView.distribution = .fillEqually
        
        [previousWeekButton, monthLabel, nextWeekButton, dayStackView, collectionView, tableView].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 15.0
        let buttonWidth: CGFloat = 25.0
        
        monthLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
        previousWeekButton.snp.makeConstraints {
            $0.trailing.equalTo(monthLabel.snp.leading).offset(-100.0)
            $0.centerY.equalTo(monthLabel.snp.centerY)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        nextWeekButton.snp.makeConstraints {
            $0.leading.equalTo(monthLabel.snp.trailing).offset(100.0)
            $0.centerY.equalTo(monthLabel.snp.centerY)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        dayStackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.top.equalTo(monthLabel.snp.bottom).offset(inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.height.equalTo(50.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.top.equalTo(dayStackView.snp.bottom)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.height.equalTo(dayStackView.snp.height)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.top.equalTo(collectionView.snp.bottom)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
    }
    
}
