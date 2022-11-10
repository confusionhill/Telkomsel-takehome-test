//
//  HomeViewController.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//
import SwiftUI
import UIKit

final class HomeViewController: UIViewController {
    let tableView: UITableView = {
        let tbv =  UITableView(frame: UIScreen.main.bounds)
        tbv.register(HostingTableViewCell<HomeTBVC>.self, forCellReuseIdentifier: "textCell")
        return tbv
    }()
    lazy var viewModel: HomeViewModelInput = {
        let vm = HomeViewModel()
        vm.viewOutput = self
        return vm
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension HomeViewController: HomeViewModelOutput {
    func setupViews() {
        self.title = "Home"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func didFinnishGetProducts() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func didFailGetProducts(error e: Error) {}
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController.create(product: viewModel.products[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! HostingTableViewCell<HomeTBVC>
        let data = viewModel.products[indexPath.row]
        cell.host(HomeTBVC(productName: data.productName, iconUrl: data.productLogo), parent: self)
        cell.backgroundColor = hexStringToUIColor(hex: data.colorTheme)
        return cell
    }
    
}
