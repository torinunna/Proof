//
//  CalendarViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import SnapKit
import UIKit

class CalendarViewController: UIViewController {
        
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        return label
    }()
    
    private lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        return button
    }()
    
    private lazy var previousMonthButton: UIButton = {
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
        previousMonth()
        nextMonth()
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
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " "
        collectionView.reloadData()
    }
    
}

//MARK:  - CollectionView Extensions

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell
        cell?.dayOfMonth.text = totalSquares[indexPath.item]
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
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonPressed() {
        let vc = AddRetroViewController()
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true)
    }
    
    func previousMonth() {
        previousMonthButton.addTarget(self, action: #selector(previousMonthPressed), for: .touchUpInside)
    }
    
    @objc func previousMonthPressed() {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    func nextMonth() {
        nextMonthButton.addTarget(self, action: #selector(nextMonthPressed), for: .touchUpInside)
    }
    
    @objc func nextMonthPressed() {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    
//MARK:  - Layout

    func setUpLayout() {
        
        let dayStackView = UIStackView(arrangedSubviews: [sundayLabel, mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel])
        dayStackView.spacing = 4.0
        dayStackView.distribution = .fillEqually
        
        [previousMonthButton, monthLabel, nextMonthButton, dayStackView, collectionView].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 15.0
        let buttonWidth: CGFloat = 25.0
        
        monthLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
        
    }
    
}
