//
//  TabBarController.swift
// Freelife
//
//  Created by ihan carlos on 08/12/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .ds(.lighGray)
        
        navigationController?.setNavigationBarHidden(true, animated: false)

        let viewController1 = HomeViewController()
        viewController1.tabBarItem = UITabBarItem(title: "Home", image: .ds(.home), tag: 0)
        
        let viewController2 = TicketViewController()
        viewController2.tabBarItem = UITabBarItem(title: "Débitos", image: .ds(.debts), tag: 1)
        
        let viewController3 = CashbackViewController()
        viewController3.tabBarItem = UITabBarItem(title: "Cashback", image: .ds(.cash), tag: 2)

        let viewController4 = ProfileViewController()
        viewController4.tabBarItem = UITabBarItem(title: "Perfil", image: .ds(.profileGray), tag: 3)

        viewControllers = [viewController1, viewController2, viewController3, viewController4]
        
        selectedIndex = 0
        customizeTabBar()
    }
}

extension UITabBarController {
    func customizeTabBar() {

        let unselectedColor = UIColor.gray
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: unselectedColor], for: .normal)
        
        let selectedColor = UIColor.ds(.generalBlue)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selectedColor], for: .selected)
        
        UITabBar.appearance().unselectedItemTintColor = unselectedColor
        
        UITabBar.appearance().tintColor = selectedColor
    }
}
