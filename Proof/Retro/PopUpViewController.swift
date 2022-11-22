//
//  PopUpViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/21.
//

import SnapKit
import UIKit

class PopUpViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "평가"
        return label
    }()
 
    private lazy var goodBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        button.setTitle("만족", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12.0)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.alignTextBelow(spacing: 5)
        return button
    }()
    
    private lazy var normalBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "face.smiling.fill"), for: .normal)
        button.setTitle("보통", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12.0)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.alignTextBelow(spacing: 5)
        return button
    }()
    
    private lazy var badBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
        button.setTitle("불만족", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12.0)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.alignTextBelow(spacing: 5)
        return button
    }()

    private lazy var doneBtn: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        doneButton()
        backgroundDismiss()
    }

}

private extension PopUpViewController {
        
    func doneButton() {
        doneBtn.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
    }
    
    @objc func donePressed() {
       dismiss(animated: true)
    }
    
    func backgroundDismiss() {
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(backgroundTap(_:))))
    }
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: false, completion: nil)
      }
    
    func setUpLayout() {
        
        view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        let buttonStackView = UIStackView(arrangedSubviews: [goodBtn, normalBtn, badBtn])
        buttonStackView.spacing = 4.0
        buttonStackView.distribution = .fillEqually
        
        [titleLabel, buttonStackView, doneBtn].forEach { containerView.addSubview($0) }
        backgroundView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.centerX.equalTo(backgroundView)
            $0.centerY.equalTo(backgroundView)
            $0.height.equalTo(250.0)
            $0.width.equalTo(300.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(containerView).inset(20.0)
        }
        
        let buttonWidth: CGFloat = 60.0
        
        goodBtn.snp.makeConstraints {
            $0.height.equalTo(buttonWidth)
            $0.width.equalTo(buttonWidth)
        }
        
        normalBtn.snp.makeConstraints {
            $0.height.equalTo(buttonWidth)
            $0.width.equalTo(buttonWidth)
        }
        
        badBtn.snp.makeConstraints{
            $0.height.equalTo(buttonWidth)
            $0.width.equalTo(buttonWidth)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalTo(containerView)
            $0.centerY.equalTo(containerView)
        }
        
        doneBtn.snp.makeConstraints {
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(buttonStackView.snp.bottom).offset(30.0)
        }
    }
    
}

