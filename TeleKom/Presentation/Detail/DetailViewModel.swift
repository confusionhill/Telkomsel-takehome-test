//
//  DetailViewModel.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

protocol DetailViewModelInput: ViewModelInput {
    var viewOutput: DetailViewModelOutput? { get set }
    var product: ProductModel? { get set }
    var searched: ProductModel? { get }
    func addProduct()
}
protocol DetailViewModelOutput: ViewModelOutput {
    func didSuccessInsertProduct()
    func didFailInsertProduct(msg: String)
}

final class DetailViewModel: DetailViewModelInput {
    weak var viewOutput: DetailViewModelOutput?
    let service: FavouriteServiceInterface
    var product: ProductModel?
    var searched: ProductModel? {
        if let prod = product {
            return service.getSpecificProduct(name: prod.productName)
        }
        return nil
    }
    func viewDidLoad() {
        viewOutput?.setupViews()
    }
    
    init(service: FavouriteServiceInterface = FavouriteService()) {
        self.service = service
    }
    
    func addProduct() {
        guard let product = product else { return }
        if let searched = self.searched {
            service.deleteProduct(product: searched)
            viewOutput?.didFailInsertProduct(msg: "Product is available at your index, no need to add")
            return
        }
        if service.insertProduct(product: product) {
            self.viewOutput?.didSuccessInsertProduct()
            return
        }
        self.viewOutput?.didFailInsertProduct(msg: "Fail to add product to index due to database malfunction")
    }
}
