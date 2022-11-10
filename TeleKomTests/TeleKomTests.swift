//
//  TeleKomTests.swift
//  TeleKomTests
//
//  Created by terminal on 10/11/22.
//

import XCTest
@testable import TeleKom

class TeleKomTests: XCTestCase {
    
    var service: ProductServiceInterface?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.service = ProductService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.service = nil
    }
    
    func testGet() {
        Task(priority: .background) {
            await service?.getProducts(completion: { result in
                switch result {
                case .success(let models):
                    print(models)
                    
                    XCTAssert(!models.isEmpty)
                default:
                    XCTFail()
                }
            })
        }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
