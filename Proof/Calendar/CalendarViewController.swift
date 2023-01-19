//
//  CalendarViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import SnapKit
import UIKit

class CalendarViewController: UIViewController {
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .medium)
        return label
    }()
        
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        return label
    }()
    
    private lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(nextMonthBtnPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var previousMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.addTarget(self, action: #selector(previousMonthBtnPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectedDate = Date()
    private lazy var totalSquares = [String]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpLayout()
        setMonthView()
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42) {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth) {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        yearLabel.text = CalendarHelper().yearString(date: selectedDate)
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
        collectionView.reloadData()
    }
    
}

//MARK:  - CollectionView Extensions

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell
        cell?.dayLabel.text = totalSquares[indexPath.item]
        cell?.setUp()
        
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 2) / 8
        let height: CGFloat = (collectionView.frame.height - 2) / 8
        
        return CGSize(width: width, height: height)
    }
}

//MARK:  - Private Extension

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
        
    }

    @objc func previousMonthBtnPressed() {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @objc func nextMonthBtnPressed() {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
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
            label.font = .systemFont(ofSize: 20.0, weight: .semibold)
            weekdayStackView.addArrangedSubview(label)
        }
        
        [previousMonthButton, yearLabel, monthLabel, nextMonthButton, weekdayStackView, collectionView].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 15.0
        let buttonWidth: CGFloat = 25.0
        
        yearLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        monthLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(yearLabel.snp.bottom).offset(6.0)
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
        
    }
    
}
