//
//  ProductModel.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

struct ProductModel: Codable {
    let uuid: Int?
    let productName: String
    let productLogo: String
    let desc: String
    let rating: Double
    let latestVersion, publisher, colorTheme: String

    enum CodingKeys: String, CodingKey {
        case uuid
        case productName, productLogo
        case desc = "description"
        case rating, latestVersion, publisher, colorTheme
    }
}
