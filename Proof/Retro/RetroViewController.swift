//
//  RetroViewController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import SnapKit
import UIKit

class RetroViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = self
        
        tableView.register(RetroListCell.self, forCellReuseIdentifier: "RetroListCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpNavigationBar()
        setUpTableView()
    }

}

//MARK:  - Extensions

extension RetroViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetroListCell", for: indexPath) as? RetroListCell
        cell?.setUp()
        
        return cell ?? RetroListCell()
    }
}


private extension RetroViewController {
    
    func setUpNavigationBar() {
        navigationItem.title = "나의 회고"
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonPressed() {
        let vc = AddRetroViewController()
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true)
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
}
