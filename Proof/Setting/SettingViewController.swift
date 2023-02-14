//
//  SettingViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import UIKit

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }

    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "MY"
    }
    
}
