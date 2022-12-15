//
//  AddRetroViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/13.
//

import SnapKit
import UIKit

class AddRetroViewController: UIViewController {
    
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

    private var retroDate: Date?
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
        return label
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10.0
        return textField
    }()
    
    private lazy var likedLabel: UILabel = {
        let label = UILabel()
        label.text = "Liked"
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
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
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
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
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
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
        label.font = .systemFont(ofSize: 25.0, weight: .bold)
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
        configureDate()
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
        let vc = PopUpViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
}
    
    func configureDate() {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        datePicker.locale = Locale(identifier: "ko-KR")
        dateTextField.inputView = datePicker
    }
    
    @objc func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        retroDate = datePicker.date
        dateTextField.text = formatter.string(from: datePicker.date)
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

        [dateLabel, dateTextField, likedLabel, likedTextView, learnedLabel, learnedTextView, lackedLabel, lackedTextView, longedForLabel, longedForTextView].forEach { contentView.addSubview($0) }
    
        let inset: CGFloat = 15.0
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(inset)
            $0.width.equalTo(100)
            $0.height.equalTo(30.0)
        }
        
        dateTextField.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(5.0)
            $0.top.equalTo(dateLabel.snp.top)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30.0)
        }
        
        likedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(dateLabel.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30.0)
        }

        likedTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(likedLabel.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(200.0)
        }

        learnedLabel.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(likedTextView.snp.bottom).offset(20.0)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30.0)
        }

        learnedTextView.snp.makeConstraints {
            $0.leading.equalTo(likedTextView.snp.leading)
            $0.top.equalTo(learnedLabel.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(200.0)
        }

        lackedLabel.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(learnedTextView.snp.bottom).offset(20.0)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30.0)
        }

        lackedTextView.snp.makeConstraints {
            $0.leading.equalTo(likedTextView.snp.leading)
            $0.top.equalTo(lackedLabel.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(200.0)
        }

        longedForLabel.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(lackedTextView.snp.bottom).offset(20.0)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30.0)
        }

        longedForTextView.snp.makeConstraints {
            $0.leading.equalTo(likedTextView.snp.leading)
            $0.top.equalTo(longedForLabel.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
            $0.height.equalTo(200.0)
        }
    
    }

}
