//
//  TestHomeViewController.swift
//  TeleKomTests
//
//  Created by terminal on 11/11/22.
//

import XCTest
@testable import TeleKom

class TestHomeViewController: XCTestCase {
    
    var view = HomeViewController()
    var viewModel = MockHomeViewModel()

    override func setUpWithError() throws {
        continueAfterFailure = false
        view.viewModel = viewModel
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewDidLoad() {
        viewModel.viewDidLoad()
        XCTAssertTrue(viewModel.viewDidLoadCalled)
    }
}
