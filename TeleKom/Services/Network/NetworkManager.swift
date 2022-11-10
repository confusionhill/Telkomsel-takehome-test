//
//  NetworkManager.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

protocol NetworkManagerInterface {
    func request<T: Codable>(
        endPoint constant: NetworkConstant,
        modelType: T.Type,
        completion: @escaping (Result<T, Error>) -> ()
    ) async
}

final class NetworkManager: NetworkManagerInterface {
    public func request<T: Codable>(
        endPoint constant: NetworkConstant,
        modelType: T.Type,
        completion: @escaping (Result<T, Error>) -> ()
    ) async {
        let request = constant.urlRequest
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decoded))
        } catch (let e) {
            completion(.failure(e))
        }
    }
}
