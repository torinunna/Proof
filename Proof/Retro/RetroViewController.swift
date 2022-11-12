//
//  RetroViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import SnapKit
import UIKit

class RetroViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpNavigationBar()
        
    }

}

private extension RetroViewController {
    
    func setUpNavigationBar() {
        navigationItem.title = "나의 회고"
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = addButton
    }
    
}
