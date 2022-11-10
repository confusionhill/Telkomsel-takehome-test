//
//  NetworkServiceMock.swift
//  TeleKomTests
//
//  Created by terminal on 10/11/22.
//

@testable import TeleKom


class MockNetworkService: NetworkManagerInterface {
    var didCallRequest = false
    func request<T>(endPoint constant: NetworkConstant, modelType: T.Type, completion: @escaping (Result<T, Error>) -> ()) async where T : Decodable, T : Encodable {
        didCallRequest = true
    }
}
