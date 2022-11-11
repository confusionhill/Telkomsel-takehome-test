//
//  HomeViewModelMock.swift
//  TeleKomTests
//
//  Created by terminal on 11/11/22.
//

@testable import TeleKom

final class MockHomeViewModel: HomeViewModelInput {
    var products: [ProductModel] = []
    
    var cellCount: Int = 0
    
    var getAllproductCalled = false
    func getAllproduct() {
        self.getAllproductCalled = true
    }
    
    var viewDidLoadCalled = false
    func viewDidLoad() {
        self.viewDidLoadCalled = true
    }
    
    
}
