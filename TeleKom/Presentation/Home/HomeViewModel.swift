//
//  HomeViewModel.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

protocol HomeViewModelInput: ViewModelInput {
    var products: [ProductModel] { get }
    var cellCount: Int { get }
    func getAllproduct()
}
protocol HomeViewModelOutput: ViewModelOutput {
    func didFinnishGetProducts()
    func didFailGetProducts(error e: Error)
}

final class HomeViewModel: HomeViewModelInput {
    weak var viewOutput: HomeViewModelOutput?
    var service: ProductServiceInterface = ProductService()
    private(set) var products: [ProductModel] = []
    public var cellCount: Int { products.count }
    
    func viewDidLoad() {
        getAllproduct()
        viewOutput?.setupViews()
    }
    
    func getAllproduct() {
        Task(priority: .background) {
            await service.getProducts(completion: { [unowned self] result in
                switch result {
                case .success(let products):
                    self.products = products
                    self.viewOutput?.didFinnishGetProducts()
                case .failure(let e):
                    self.viewOutput?.didFailGetProducts(error: e)
                }
            })
        }
    }
}
