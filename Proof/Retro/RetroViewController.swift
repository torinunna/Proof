//
//  RetroViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import SnapKit
import UIKit

var selectedDate = Date()

class RetroViewController: UIViewController {
        
    let calendar = Calendar.current
    var totalSquares = [Date]()
    
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
        selectedDate = calendar.date(byAdding: DateComponents(day: -7), to: selectedDate) ?? Date()
        setWeekView()
    }
    
    private lazy var nextWeekButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.addTarget(self, action: #selector(nextWeekBtnPressed), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    @objc func nextWeekBtnPressed() {
        selectedDate = calendar.date(byAdding: DateComponents(day: +7), to: selectedDate) ?? Date()
        setWeekView()
    }
    
    private lazy var weekdayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
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
        setUpStackView()
        setWeekView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func setUpStackView() {
        let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let label = UILabel()
            label.text = weekdays[i]
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 17.0, weight: .medium)
            
            if i == 0 {
                label.textColor = UIColor.red
            } else {
                label.textColor = UIColor.black
            }
            
            weekdayStackView.addArrangedSubview(label)
        }
        
    }
    
    func setWeekView() {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextsunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextsunday) {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        collectionView.reloadData()
        tableView.reloadData()
    }
    
}

//MARK:  - CollectionView Extensions

extension RetroViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
        
        let date = totalSquares[indexPath.item]
        cell.dayLabel.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == selectedDate) {
            cell.backgroundColor = UIColor.black
            cell.dayLabel.textColor = UIColor.white
            titleLabel.text = CalendarHelper().yearString(date: selectedDate) + " " + CalendarHelper().monthString(date: selectedDate)
        } else {
            cell.backgroundColor = UIColor.white
            cell.dayLabel.textColor = UIColor.black
        }

        cell.weeklySetUp()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
}

extension RetroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 2) / 7
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}
//MARK:  - TableView Extension

extension RetroViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Retro().retrosForDate(date: selectedDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RetroListCell.identifier, for: indexPath) as? RetroListCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setUp()
        let retro = Retro().retrosForDate(date: selectedDate)[indexPath.row]
        cell.categorylabel.text = retro.category
        cell.likedContents.text = retro.liked
        cell.lackedContents.text = retro.lacked
        cell.learnedContents.text = retro.learned
        cell.longedForContents.text = retro.longedFor
        return cell
    }
    
}

//MARK:  - Private Extension

private extension RetroViewController {
    
    func setUpNavigationBar() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addBtnPressed))
        navigationItem.rightBarButtonItem = addButton
        let todayButton = UIBarButtonItem(title: "오늘", style: .plain, target: self, action: #selector(todayBtnPressed))
        navigationItem.leftBarButtonItem = todayButton
    }
    
    @objc func addBtnPressed() {
        let vc = AddRetroViewController()
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true)
    }
    
    @objc func todayBtnPressed() {
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        selectedDate = calendar.date(from: components) ?? Date()
        setWeekView()
    }
    
//MARK:  - Layout

    func setUpLayout() {
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
            $0.top.equalTo(collectionView.snp.bottom).offset(8.0)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
    }
    
}
