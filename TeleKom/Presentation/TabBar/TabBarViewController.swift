//
//  TabBarViewController.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import UIKit

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        var vcs = [UIViewController]()
        TabBarConstant.allCases.forEach { c in
            vcs.append(UINavigationController(rootViewController: c.viewController))
        }
        self.viewControllers = vcs
        self.selectedIndex = 0
    }

}
