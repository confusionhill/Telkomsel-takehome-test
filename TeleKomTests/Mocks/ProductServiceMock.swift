//
//  ProductServiceMock.swift
//  TeleKomTests
//
//  Created by terminal on 10/11/22.
//

@testable import TeleKom

class MockProductService: ProductServiceInterface {
    var didCallGetProducts = false
    func getProducts(completion: @escaping (Result<[ProductModel], Error>) -> ()) async {
        didCallGetProducts = true
        completion(.success([]))
    }
}
