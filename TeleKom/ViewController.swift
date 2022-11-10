//
//  ViewController.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = ProductService()
        Task(priority: .background) {
            await service.getProducts(completion: { result in
                switch result {
                case .success(let models):
                    print("makanan : ", models[0])                 
                default:
                    print("woahh")
                    
                }
            })
        }
    }


}

