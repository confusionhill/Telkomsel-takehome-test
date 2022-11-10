//
//  NetworkConstant.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

enum NetworkConstant {
    private enum httpMethod: String {
        case get = "GET"
        case post = "POST"
    }
    private enum apiVersion: String {
        case v2 = "v2"
    }
    
    case products

    private var root: String { "https://apimocha.com/telkom" }
    private var url: URL { URL(string: "\(root)/\(version.rawValue)/\(path)")!}
    
    public var urlRequest: URLRequest {
        var req = URLRequest(url: self.url)
        req.httpMethod = method.rawValue
        return req
    }
    
    private var version: apiVersion {
        switch self {
        case .products:
            return .v2
        }
    }
    
    private var method: httpMethod {
        switch self {
        case .products:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .products:
            return "products"
        }
    }
}
