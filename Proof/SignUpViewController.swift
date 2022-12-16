//
//  SignUpViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/08.
//

import Firebase
import SnapKit
import UIKit

class SignUpViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        label.textColor = .label
        
        return label
    }()
    
    var idTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.placeholder = "이메일을 입력해 주세요."
        textField.textColor = .label
        textField.font = .systemFont(ofSize: 15.0)
        
        return textField
    }()
    
    var pwTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.placeholder = "비밀번호를 입력해 주세요."
        textField.textColor = .label
        textField.font = .systemFont(ofSize: 15.0)
        
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("가입하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(signUpBtnPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }

}

//MARK:  - Extension

private extension SignUpViewController {
 
    @objc func signUpBtnPressed() {
        if let email = idTextField.text, let password = pwTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.alert()
                }
            }
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: nil, message: "회원가입 성공!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    //MARK:  - Layout
    
    func setUpLayout() {
        
        [titleLabel, idTextField, pwTextField, signUpButton].forEach { view.addSubview($0) }
        
        view.backgroundColor = .white
        
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

        signUpButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40.0)
            $0.top.equalTo(pwTextField.snp.bottom).offset(50.0)
            $0.trailing.equalToSuperview().inset(40.0)
            $0.height.equalTo(40.0)
        }
    }
    
    
}
