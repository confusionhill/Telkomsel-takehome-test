//
//  TabBar.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import UIKit

enum TabBarConstant: String, CaseIterable {
    case home = "Home"
    case fav = "Favourite"
    
    var name: String { self.rawValue }
    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")!
        case .fav:
            return UIImage(systemName: "book.closed.fill")!
        }
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: self.name, image: self.icon, selectedImage: self.icon)
    }
    public var viewController: UIViewController {
        var vc: UIViewController!
        switch self {
        case .home:
            vc = HomeViewController()
        case .fav:
            vc = FavouriteViewController()
        }
        vc.tabBarItem = self.tabBarItem
        return vc
    }
}
