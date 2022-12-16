//
//  SignInViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import Firebase
import SnapKit
import UIKit

class SignInViewController: UIViewController {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Proof."
        label.font = .systemFont(ofSize: 40.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    var idTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.placeholder = "이메일을 입력하세요."
        textField.textColor = .label
        textField.font = .systemFont(ofSize: 15.0)
        
        return textField
    }()
    
    var pwTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.placeholder = "비밀번호를 입력하세요."
        textField.isSecureTextEntry = true
        textField.textColor = .label
        textField.font = .systemFont(ofSize: 15.0)
        
        return textField
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(signInBtnPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(signUpBtnPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
    }
    
}

//MARK:  - Extension

private extension SignInViewController {
    
    @objc func signInBtnPressed() {
        if let email = idTextField.text, let password = pwTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }

    @objc func signUpBtnPressed() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK:  - Layout
    
    func setUpLayout() {
        
        [titleLabel, idTextField, pwTextField, signInButton, signUpButton].forEach { view.addSubview($0) }
        
        let viewInset: CGFloat = 16.0
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(viewInset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50.0)
        }
        
        idTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(titleLabel.snp.bottom).offset(80.0)
            $0.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(30.0)
        }
        
        pwTextField.snp.makeConstraints {
            $0.leading.equalTo(idTextField.snp.leading)
            $0.top.equalTo(idTextField.snp.bottom).offset(viewInset)
            $0.trailing.equalTo(idTextField.snp.trailing)
            $0.height.equalTo(30.0)
        }
        
        signInButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40.0)
            $0.top.equalTo(pwTextField.snp.bottom).offset(50.0)
            $0.trailing.equalToSuperview().inset(40.0)
            $0.height.equalTo(40.0)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.equalTo(signInButton.snp.leading)
            $0.top.equalTo(signInButton.snp.bottom).offset(viewInset)
            $0.trailing.equalTo(signInButton.snp.trailing)
            $0.height.equalTo(40.0)
        }
        
    }
}
