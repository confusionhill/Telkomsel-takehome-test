//
//  FavouriteService.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation
import SQLite3

protocol FavouriteServiceInterface: AnyObject {
    func insertProduct(product model: ProductModel) -> Bool
    func getProduct() -> [ProductModel]
    func getSpecificProduct(name: String) -> ProductModel?
    func deleteProduct(product model: ProductModel)
}

public final class FavouriteService: FavouriteServiceInterface {
    private let manager: DatabaseManager
    
    init(dbManager manager: DatabaseManager = DatabaseManager.shared) {
        self.manager = manager
    }
    
    func insertProduct(product model: ProductModel) -> Bool{
        let query = "INSERT INTO favourite(productName,productLogo, desc, rating, latestVersion, publisher, colorTheme) VALUES(?,?,?,?,?,?,?);"
        var statement: OpaquePointer? = nil
        guard sqlite3_prepare_v2(manager.db, query, -1, &statement, nil) == SQLITE_OK else { return false }
        sqlite3_bind_text(statement, 1, (model.productName as NSString).utf8String, -1, nil)
        sqlite3_bind_text(statement, 2, (model.productLogo as NSString).utf8String, -1, nil)
        sqlite3_bind_text(statement, 3, (model.desc as NSString).utf8String, -1, nil)
        sqlite3_bind_double(statement, 4, model.rating)
        sqlite3_bind_text(statement, 5, (model.latestVersion as NSString).utf8String, -1, nil)
        sqlite3_bind_text(statement, 6, (model.publisher as NSString).utf8String, -1, nil)
        sqlite3_bind_text(statement, 7, (model.colorTheme as NSString).utf8String, -1, nil)
        let state = sqlite3_step(statement) == SQLITE_DONE
        if !state {
            NSLog("Item not added")
        }
        sqlite3_finalize(statement)
        return state
    }
    func getProduct() -> [ProductModel] {
        var products = [ProductModel]()
        let query = "SELECT * FROM favourite"
        var statement: OpaquePointer? = nil
        guard sqlite3_prepare_v2(manager.db, query, -1, &statement, nil) == SQLITE_OK else { return [] }
        while sqlite3_step(statement) == SQLITE_ROW {
            let id: Int = Int(sqlite3_column_int(statement, 0))
            let productName = String(describing: String(cString: sqlite3_column_text(statement, 1)))
            let productLogo = String(describing: String(cString: sqlite3_column_text(statement, 2)))
            let desc = String(describing: String(cString: sqlite3_column_text(statement, 3)))
            let rating: Double = sqlite3_column_double(statement, 4)
            let latestVersion = String(describing: String(cString: sqlite3_column_text(statement, 5)))
            let publisher = String(describing: String(cString: sqlite3_column_text(statement, 6)))
            let colorTheme = String(describing: String(cString: sqlite3_column_text(statement, 7)))
            products.append(.init(uuid: id, productName: productName, productLogo: productLogo,
                                  desc: desc, rating: rating, latestVersion: latestVersion,
                                  publisher: publisher, colorTheme: colorTheme))
            
        }
        sqlite3_finalize(statement)
        return products
    }
    
    func getSpecificProduct(name: String) -> ProductModel? {
        var product: ProductModel?
        let query = "SELECT * FROM favourite WHERE productName=?;"
        var statement: OpaquePointer? = nil
        guard sqlite3_prepare_v2(manager.db, query, -1, &statement, nil) == SQLITE_OK else { return nil }
        sqlite3_bind_text(statement, 1, (name as NSString).utf8String, -1, nil)
        while sqlite3_step(statement) == SQLITE_ROW {
            let id: Int = Int(sqlite3_column_int(statement, 0))
            let productName = String(describing: String(cString: sqlite3_column_text(statement, 1)))
            let productLogo = String(describing: String(cString: sqlite3_column_text(statement, 2)))
            let desc = String(describing: String(cString: sqlite3_column_text(statement, 3)))
            let rating: Double = sqlite3_column_double(statement, 4)
            let latestVersion = String(describing: String(cString: sqlite3_column_text(statement, 5)))
            let publisher = String(describing: String(cString: sqlite3_column_text(statement, 6)))
            let colorTheme = String(describing: String(cString: sqlite3_column_text(statement, 7)))
            product = .init(uuid: id, productName: productName, productLogo: productLogo,
                                  desc: desc, rating: rating, latestVersion: latestVersion,
                                  publisher: publisher, colorTheme: colorTheme)
            
        }
        sqlite3_finalize(statement)
        return product
    }
    
    func deleteProduct(product model: ProductModel) {
        let query = "DELETE FROM favourite WHERE id = ?;"
        var statement: OpaquePointer? = nil
        do {
            if sqlite3_prepare_v2(manager.db, query, -1, &statement, nil) != SQLITE_OK {
                throw DatabaseError.query("Query not available")
            }
            if let id = model.uuid {
                sqlite3_bind_int(statement, 1, Int32(id))
            }
            if sqlite3_step(statement) != SQLITE_DONE {
                throw DatabaseError.end("Could not end")
            }
            sqlite3_finalize(statement)
        } catch (let e) {
            NSLog(e.localizedDescription)
        }
    }
    
}
