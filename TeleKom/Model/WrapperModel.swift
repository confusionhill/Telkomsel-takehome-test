//
//  WrapperModel.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import Foundation

struct Wrapper<T: Codable>: Codable {
    let ok: Bool
    let data: [T]
    let message: String
    let status: Int
}
