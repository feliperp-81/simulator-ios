//
//  URLComponents+Extensions.swift
//  simulator
//
//  Created by Felipe Rodrigues on 18/09/19.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
