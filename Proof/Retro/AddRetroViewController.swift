//
//  AddRetroViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/13.
//

import SnapKit
import UIKit

class AddRetroViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpNavigationBar()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonPressed))
    }
    
    @objc func saveButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true)
    }

}