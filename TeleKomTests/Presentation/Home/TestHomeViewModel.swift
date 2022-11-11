//
//  TestHomeViewModel.swift
//  TeleKomTests
//
//  Created by terminal on 11/11/22.
//

import XCTest
@testable import TeleKom

class TestHomeViewModel: XCTestCase {
    
    var viewModel = HomeViewModel()
    var view = MockHomeViewController()
    override func setUpWithError() throws {
        viewModel.viewOutput = view
        viewModel.service = MockProductService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoad() {
        viewModel.viewDidLoad()
        XCTAssertTrue(view.didSetupViewsCalled)
    }
    
    func testGetProduct() {
        viewModel.getAllproduct()
        XCTAssertTrue(view.didGetProductCalled)
    }

}
