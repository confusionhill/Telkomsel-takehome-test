//
//  DatabaseService.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation
import SQLite3

enum DatabaseError: Error {
    case loadDB(String)
    case query(String)
    case end(String)
}

final class DatabaseManager {
    private let dbPath: String = "myDb.sqlite"
    private(set) var db:OpaquePointer?
    public static let shared = DatabaseManager()
    
    init() {
        self.db = initDB()
        initTable()
    }

    
    private func initDB() -> OpaquePointer? {
        do {
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(dbPath)
            var db: OpaquePointer?
            guard sqlite3_open(filePath.path, &db) == SQLITE_OK else {
                throw DatabaseError.loadDB("Database could not be load")
            }
            return db
        } catch (let e) {
            NSLog(e.localizedDescription)
            return nil
        }
    }
    
    private func initTable() {
        let query = "CREATE TABLE IF NOT EXISTS favourite(id INTEGER PRIMARY KEY,productName TEXT,productLogo TEXT, desc TEXT, rating REAL, latestVersion TEXT, publisher TEXT, colorTheme TEXT);"
        var statement: OpaquePointer? = nil
        guard
            sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK,
            sqlite3_step(statement) == SQLITE_DONE  else { return }
        sqlite3_finalize(statement)
    }
}
