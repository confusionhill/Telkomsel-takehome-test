//
//  HomeViewControllerMock.swift
//  TeleKomTests
//
//  Created by terminal on 11/11/22.
//

@testable import TeleKom


final class MockHomeViewController: HomeViewModelOutput {
    var didGetProductCalled = false
    func didFinnishGetProducts() {
        self.didGetProductCalled = true
    }
    
    func didFailGetProducts(error e: Error) {}
    
    var didSetupViewsCalled = false
    func setupViews() {
        didSetupViewsCalled = true
    }
    
    
}
