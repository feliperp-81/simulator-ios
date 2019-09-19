//
//  Response.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

struct ResponseHandler<T: Decodable> {
    private let data: Data?
    private let httpResponse: HTTPURLResponse?

    init(data: Data?, httpResponse: HTTPURLResponse?) {
        self.data = data
        self.httpResponse = httpResponse
    }

    func getModel() -> T? {
        guard
            let data = data,
            let httpResponse = httpResponse,
            let object = try? T.init(with: data),
            (200...299).contains(httpResponse.statusCode)
        else {
            return nil
        }

        return object
    }
}
