//
//  TabBarController.swift
//  BauBuddyTaskList
//
//  Created by Sena Kurtak on 19.02.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let firstVC = CustomViewController()
        let secondVC = QRScanningViewController()
        self.setViewControllers([firstVC,secondVC], animated: true)
        firstVC.title = "Home"
        firstVC.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        secondVC.title = "SCAN"
        secondVC.tabBarItem = UITabBarItem.init(title: "SCAN", image: UIImage(systemName: "qrcode.viewfinder"), tag: 0)
        self.tabBar.barTintColor = UIColor(.white)
        
    }
}
