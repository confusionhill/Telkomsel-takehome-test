//
//  ProductService.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

protocol ProductServiceInterface {
    func getProducts(completion: @escaping (Result<[ProductModel], Error>) -> ()) async
}

final class ProductService: ProductServiceInterface {
    private let manager: NetworkManagerInterface
    
    init(manager: NetworkManagerInterface = NetworkManager()) {
        self.manager = manager
    }
    
    func getProducts(completion: @escaping (Result<[ProductModel], Error>) -> ()) async {
        await manager.request(
            endPoint: .products,
            modelType: Wrapper<ProductModel>.self,
            completion: { result in
                switch result {
                case .failure(let e):
                    completion(.failure(e))
                case .success(let wrapper):
                    completion(.success(wrapper.data))
                }
        })
    }
}
