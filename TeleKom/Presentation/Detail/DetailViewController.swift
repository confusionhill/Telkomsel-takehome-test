//
//  DetailViewController.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import UIKit
import SwiftUI

final class DetailViewController: UIViewController, DetailViewModelOutput {
    public static func create(product: ProductModel) -> DetailViewController {
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.product = product
        return vc
    }
    @IBOutlet weak var containerView: UIView!
    var product: ProductModel?
    var viewModel: DetailViewModelInput = DetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewOutput = self
        viewModel.viewDidLoad()
    }
    
    @objc
    func didTapLoveBtn(_ sender: UIBarButtonItem) {
        viewModel.addProduct()
    }
    
    func didSuccessInsertProduct() {
        let loveBtn = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain, target: self, action: #selector(self.didTapLoveBtn(_:)))
        navigationItem.rightBarButtonItem = loveBtn
    }
    
    func didFailInsertProduct(msg: String) {
        let loveBtn = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain, target: self, action: #selector(self.didTapLoveBtn(_:)))
        navigationItem.rightBarButtonItem = loveBtn
    }
    
    func setupViews() {
        if let product = product {
            viewModel.product = product
            self.title = product.productName
            let childView = UIHostingController(rootView: DetailView(product: product))
            childView.view.backgroundColor = .clear
            addChild(childView)
            childView.view.frame = containerView.bounds
            containerView.addSubview(childView.view)
            childView.didMove(toParent: self)
            self.view.backgroundColor = hexStringToUIColor(hex: product.colorTheme)
        }
        
        let inList = viewModel.searched != nil
        let name = inList ? "heart.fill" :"heart"
        
        let loveBtn = UIBarButtonItem(
            image: UIImage(systemName: name),
            style: .plain, target: self, action: #selector(self.didTapLoveBtn(_:)))
        navigationItem.rightBarButtonItem = loveBtn
    }
}
