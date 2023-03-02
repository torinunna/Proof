//
//  AddRetroViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/13.
//

import SnapKit
import UIKit

class AddRetroViewController: UIViewController {
    
    var categoryString: String?
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    let fontSize: CGFloat = 17.0
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = .systemFont(ofSize: fontSize, weight: .semibold)
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        return datePicker
    }()
    
    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        return stackView
    }()
    
    private lazy var dailyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Daily", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: fontSize, weight: .medium)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(categoryBtnPressed(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var weeklyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Weekly", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: fontSize, weight: .medium)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(categoryBtnPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var monthlyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Monthly", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: fontSize, weight: .medium)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(categoryBtnPressed(_:)), for: .touchUpInside)
        return button
    }()

    @objc private func categoryBtnPressed(_ sender: UIButton) {
        
        for button in [dailyButton, weeklyButton, monthlyButton] {
            button.isSelected = false
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = .white
        }

        sender.isSelected = true
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = .black
        
        switch sender {
        case dailyButton:
            categoryString = "Daily"
        case weeklyButton:
            categoryString = "Weekly"
        case monthlyButton:
            categoryString = "Monthly"
        default:
            categoryString = nil
        }
    }
    
    private lazy var likedLabel: UILabel = {
        let label = UILabel()
        label.text = "Liked"
        label.font = .systemFont(ofSize: fontSize, weight: .semibold)
        return label
    }()
    
    private lazy var likedTextView: UITextView = {
        let textView = UITextView()
        textView.text = "좋았던 점을 남겨주세요!"
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15.0)
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        textView.isScrollEnabled = true
        textView.delegate = self
        return textView
    }()
    
    private lazy var learnedLabel: UILabel = {
        let label = UILabel()
        label.text = "Learned"
        label.font = .systemFont(ofSize: fontSize, weight: .semibold)
        return label
    }()
    
    private lazy var learnedTextView: UITextView = {
        let textView = UITextView()
        textView.text = "배운 점을 남겨주세요!"
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15.0)
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        textView.isScrollEnabled = true
        textView.delegate = self
        return textView
    }()
    
    private lazy var lackedLabel: UILabel = {
        let label = UILabel()
        label.text = "Lacked"
        label.font = .systemFont(ofSize: fontSize, weight: .semibold)
        return label
    }()
    
    private lazy var lackedTextView: UITextView = {
        let textView = UITextView()
        textView.text = "아쉬웠던 점을 남겨주세요!"
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15.0)
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        textView.isScrollEnabled = true
        textView.delegate = self
        return textView
    }()
    
    private lazy var longedForLabel: UILabel = {
        let label = UILabel()
        label.text = "Longed For"
        label.font = .systemFont(ofSize: fontSize, weight: .semibold)
        return label
    }()
    
    private lazy var longedForTextView: UITextView = {
        let textView = UITextView()
        textView.text = "앞으로 바라는 점을 남겨주세요!"
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15.0)
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        textView.isScrollEnabled = true
        textView.delegate = self
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpLayout()
        datePicker.date = selectedDate
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK:  - Extensions

extension AddRetroViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        textView.text = nil
        textView.textColor = .label
    }
}

private extension AddRetroViewController {
    
    func setUpNavigationBar() {
        navigationItem.title = "회고 작성"
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(cancelBtnPressed))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveBtnPressed))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func cancelBtnPressed() {
        dismiss(animated: true)
    }
    
    @objc func saveBtnPressed() {
        let newRetro = Retro()
        newRetro.id = retrosList.count
        newRetro.date = datePicker.date
        newRetro.category = categoryString
        newRetro.liked = likedTextView.text
        newRetro.lacked = lackedTextView.text
        newRetro.learned = learnedTextView.text
        newRetro.longedFor = longedForTextView.text
        
        retrosList.append(newRetro)
        dismiss(animated: true)
    }
    
    //MARK:  - Layout
    
    func setUpLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }

        [dateLabel, datePicker, categoryStackView, likedLabel, likedTextView, learnedLabel, learnedTextView, lackedLabel, lackedTextView, longedForLabel, longedForTextView].forEach { contentView.addSubview($0) }
    
        [dailyButton, weeklyButton, monthlyButton].forEach { categoryStackView.addArrangedSubview($0) }
        
        let inset: CGFloat = 20.0
        let offset: CGFloat = 15.0
        let secondOffset: CGFloat = 10.0
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30.0)
            $0.top.equalToSuperview().inset(inset)
            $0.width.equalTo(60.0)
        }
        
        datePicker.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing)
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(50.0)
        }
        
        categoryStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(inset)
            $0.top.equalTo(datePicker.snp.bottom).offset(secondOffset)
        }
        
        likedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(categoryStackView.snp.bottom).offset(offset)
            $0.trailing.equalToSuperview().inset(inset)
            
        }

        likedTextView.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(likedLabel.snp.bottom).offset(secondOffset)
            $0.trailing.equalTo(likedLabel.snp.trailing)
            $0.height.equalTo(200.0)
        }

        learnedLabel.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(likedTextView.snp.bottom).offset(offset)
            $0.trailing.equalTo(likedLabel.snp.trailing)
        }

        learnedTextView.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(learnedLabel.snp.bottom).offset(secondOffset)
            $0.trailing.equalTo(likedLabel.snp.trailing)
            $0.height.equalTo(200.0)
        }

        lackedLabel.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(learnedTextView.snp.bottom).offset(offset)
            $0.trailing.equalTo(likedLabel.snp.trailing)
        }

        lackedTextView.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(lackedLabel.snp.bottom).offset(secondOffset)
            $0.trailing.equalTo(likedLabel.snp.trailing)
            $0.height.equalTo(200.0)
        }

        longedForLabel.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(lackedTextView.snp.bottom).offset(offset)
            $0.trailing.equalTo(likedLabel.snp.trailing)
        }

        longedForTextView.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(longedForLabel.snp.bottom).offset(secondOffset)
            $0.trailing.equalTo(likedLabel.snp.trailing)
            $0.bottom.equalToSuperview().inset(inset)
            $0.height.equalTo(200.0)
        }
    
    }

}
