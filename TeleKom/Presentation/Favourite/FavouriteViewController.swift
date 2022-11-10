//
//  FavouriteViewController.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import UIKit

final class FavouriteViewController: UIViewController, FavouriteViewModelOutput {
    let tableView: UITableView = {
        let tbv =  UITableView(frame: UIScreen.main.bounds)
        tbv.register(HostingTableViewCell<HomeTBVC>.self, forCellReuseIdentifier: "textCell")
        return tbv
    }()
    
    var viewModel: FavouriteViewModelInput = FavouriteViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewOutput = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear?()
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        self.title = "Bookmarked"
    }
    
    func didSuccessUpdateProduct() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! HostingTableViewCell<HomeTBVC>
        let data = viewModel.products[indexPath.row]
        cell.host(HomeTBVC(productName: data.productName, iconUrl: data.productLogo), parent: self)
        cell.backgroundColor = hexStringToUIColor(hex: data.colorTheme)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController.create(product: viewModel.products[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
