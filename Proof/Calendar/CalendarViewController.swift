//
//  CalendarViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import SnapKit
import UIKit

class CalendarViewController: UIViewController {
    
    var totalSquares = [CalendarDay]()
    let calendar = Calendar.current
    var selectedDateString: String?
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        return label
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        return label
    }()
    
    private lazy var previousMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(previousMonthBtnPressed), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    @objc func previousMonthBtnPressed() {
        selectedDate = helper.minusMonth(date: selectedDate)
        setMonthView()
    }
    
    private lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.addTarget(self, action: #selector(nextMonthBtnPressed), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    @objc func nextMonthBtnPressed() {
        selectedDate = helper.plusMonth(date: selectedDate)
        setMonthView()
    }
    
    private lazy var weekdayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15.0)
        tableView.layer.borderWidth = 1.5
        tableView.layer.borderColor = UIColor.systemGray.cgColor
        tableView.layer.cornerRadius = 10.0
        
        tableView.dataSource = self
        
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpLayout()
        setUpStackView()
        setMonthView()
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

    func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = helper.daysInMonth(date: selectedDate)
        let firstDayOfMonth = helper.firstOfMonth(date: selectedDate)
        let startingSpaces = helper.weekDay(date: firstDayOfMonth)
        
        let prevMonth = helper.minusMonth(date: selectedDate)
        let daysInPrevMonth = helper.daysInMonth(date: prevMonth)
        
        var count: Int = 1
        
        while count <= 42 {
            let calendarDay = CalendarDay()
            
            if count <= startingSpaces {
                let prevMonthDay = daysInPrevMonth - startingSpaces + count
                calendarDay.day = String(prevMonthDay)
                calendarDay.month = CalendarDay.Month.previous
            } else if count - startingSpaces > daysInMonth {
                calendarDay.day = String(count - daysInMonth - startingSpaces)
                calendarDay.month = CalendarDay.Month.next
            } else {
                calendarDay.day = String(count - startingSpaces)
                calendarDay.month = CalendarDay.Month.current
            }
            
            totalSquares.append(calendarDay)
            count += 1
        }
        
        yearLabel.text = helper.yearString(date: selectedDate)
        monthLabel.text = helper.monthString(date: selectedDate)
        
        collectionView.reloadData()
    }

}

//MARK:  - CollectionView Extension

extension CalendarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        
        let calendarDay = totalSquares[indexPath.item]
        cell.dayLabel.text = calendarDay.day
        
        if calendarDay.month == CalendarDay.Month.current {
            cell.dayLabel.textColor = UIColor.black
            cell.dayLabel.font = .systemFont(ofSize: 16.0, weight: .medium)
        } else {
            cell.dayLabel.textColor = UIColor.gray
        }

        cell.monthlySetUp()
        
        return cell
    }
    
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.size.width - 2) / 7
        let height: CGFloat = (collectionView.frame.size.height - 2) / 6

        return CGSize(width: width, height: height)
    }
    
}

//MARK:  - TableView Extension

extension CalendarViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.identifier, for: indexPath) as? CalendarTableViewCell else { return UITableViewCell() }
        cell.setUp()
        cell.selectionStyle = .none
        return cell
    }
    
}

//MARK:  - NavigationBar

private extension CalendarViewController {
    
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
        let components = calendar.dateComponents([.year, .month], from: Date())
        selectedDate = calendar.date(from: components) ?? Date()
        setMonthView()
    }
    
//MARK:  - Layout
    
    func setUpLayout() {
        [yearLabel, monthLabel, previousMonthButton, nextMonthButton, weekdayStackView, collectionView, tableView].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 6.0
        let buttonWidth: CGFloat = 25.0
        
        yearLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
        monthLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(yearLabel.snp.bottom).offset(inset)
        }
        
        previousMonthButton.snp.makeConstraints {
            $0.trailing.equalTo(monthLabel.snp.leading).offset(-100.0)
            $0.centerY.equalTo(monthLabel.snp.centerY)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        nextMonthButton.snp.makeConstraints {
            $0.leading.equalTo(monthLabel.snp.trailing).offset(100.0)
            $0.centerY.equalTo(monthLabel.snp.centerY)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        weekdayStackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.top.equalTo(monthLabel.snp.bottom).offset(inset)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.height.equalTo(50.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.top.equalTo(weekdayStackView.snp.bottom)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.height.equalTo(weekdayStackView.snp.height).multipliedBy(7)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15.0)
            $0.top.equalTo(collectionView.snp.bottom).offset(inset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
    }
    
}
