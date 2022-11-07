//
//  TabBarController.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/07.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let retroViewController = UINavigationController(rootViewController: RetroViewController())
        retroViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))
        
        let calendarViewController = UINavigationController(rootViewController: CalendarViewController())
        calendarViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar"))
        
        let settingViewController = UINavigationController(rootViewController: SettingViewController())
        settingViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [retroViewController, calendarViewController, settingViewController]
    }
    
}
