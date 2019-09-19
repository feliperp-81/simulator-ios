//
//  Endpoint.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

struct Endpoint {
    private var scheme = "https"
    private var host = "api-simulator-calc.easynvest.com.br"

    let path: String
    let parameters: [String: String]

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.setQueryItems(with: parameters)

        return components.url
    }

    init(path: String, parameters: [String: String]) {
        self.path = path
        self.parameters = parameters
    }
}
