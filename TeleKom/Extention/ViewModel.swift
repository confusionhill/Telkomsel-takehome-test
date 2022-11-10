//
//  ViewModel.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

@objc protocol ViewModelInput {
    func viewDidLoad()
    @objc optional func viewWillAppear()
}

@objc protocol ViewModelOutput: AnyObject {
    func setupViews()
}
