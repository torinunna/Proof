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
    
    private lazy var dailyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Daily", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 3.0
        return button
    }()
    
    private lazy var weeklyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Weekly", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 3.0
        return button
    }()
    
    private lazy var monthlyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Monthly", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 3.0
        return button
    }()
    
    private lazy var quarterlyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Daily", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 3.0
        return button
    }()
    
    private lazy var liked: UILabel = {
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
    
    private lazy var learned: UILabel = {
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
    
    private lazy var lacked: UILabel = {
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
    
    private lazy var longedFor: UILabel = {
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일(E)"
        let today = dateFormatter.string(from: Date())
        navigationItem.title = "\(today)"
        
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonPressed() {
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
        
        let buttonStackView = UIStackView(arrangedSubviews: [dailyButton, weeklyButton, monthlyButton, quarterlyButton])
        buttonStackView.spacing = 3.0
        buttonStackView.distribution = .fillEqually
        
        [buttonStackView, liked, likedTextView, learned, learnedTextView, lacked, lackedTextView, longedFor, longedForTextView].forEach { contentView.addSubview($0) }
    
        let inset: CGFloat = 15.0
        
        buttonStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10.0)
            $0.top.equalToSuperview().inset(10.0)
            $0.trailing.equalToSuperview().inset(10.0)
            $0.height.equalTo(40.0)
        }

        liked.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(buttonStackView.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30.0)
        }

        likedTextView.snp.makeConstraints {
            $0.leading.equalTo(liked.snp.leading)
            $0.top.equalTo(liked.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(200.0)
        }

        learned.snp.makeConstraints {
            $0.leading.equalTo(liked.snp.leading)
            $0.top.equalTo(likedTextView.snp.bottom).offset(20.0)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30.0)
        }

        learnedTextView.snp.makeConstraints {
            $0.leading.equalTo(liked.snp.leading)
            $0.top.equalTo(learned.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(200.0)
        }

        lacked.snp.makeConstraints {
            $0.leading.equalTo(liked.snp.leading)
            $0.top.equalTo(learnedTextView.snp.bottom).offset(20.0)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30.0)
        }

        lackedTextView.snp.makeConstraints {
            $0.leading.equalTo(liked.snp.leading)
            $0.top.equalTo(lacked.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(200.0)
        }

        longedFor.snp.makeConstraints {
            $0.leading.equalTo(liked.snp.leading)
            $0.top.equalTo(lackedTextView.snp.bottom).offset(20.0)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30.0)
        }

        longedForTextView.snp.makeConstraints {
            $0.leading.equalTo(liked.snp.leading)
            $0.top.equalTo(longedFor.snp.bottom).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
            $0.height.equalTo(200.0)
        }
    
    }

}
