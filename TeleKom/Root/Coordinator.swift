//
//  Coordinator.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
}

final class RootCoordinator: Coordinator {
    public static let shared = RootCoordinator()
    var window:UIWindow?
    private(set) var navigationController: UINavigationController = UINavigationController()
    public func start() {
        let vc = TabBarViewController()
        //self.navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

