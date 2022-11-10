//
//  FavouriteViewModel.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

protocol FavouriteViewModelInput: ViewModelInput {
    var products: [ProductModel] { get }
    var viewOutput: FavouriteViewModelOutput? { get set }
    var cellCount: Int { get }
}
protocol FavouriteViewModelOutput: ViewModelOutput {
    func didSuccessUpdateProduct()
}

final class FavouriteViewModel: FavouriteViewModelInput {
    weak var viewOutput: FavouriteViewModelOutput?
    private let service: FavouriteServiceInterface
    
    private(set) var products: [ProductModel]  = []
    var cellCount: Int { products.count }
    
    init(service: FavouriteServiceInterface = FavouriteService()) {
        self.service = service
    }
    
    func viewWillAppear() {
        getProducts()
    }
    
    func viewDidLoad() {
        viewOutput?.setupViews()
    }
    
    func getProducts() {
        products = service.getProduct()
        viewOutput?.didSuccessUpdateProduct()
    }
    func deleteProduct() {
        
    }
}
