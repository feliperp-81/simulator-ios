//
//  Codable+Extensions.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

extension Decodable {
    init(with data: Data) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.serverDateFormatter)
        self = try decoder.decode(Self.self, from: data)
    }
}
