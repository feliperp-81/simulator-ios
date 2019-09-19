//
//  BaseTestClass.swift
//  simulatorTests
//
//  Created by Felipe Rodrigues on 18/09/19.
//

import XCTest

class BaseTestClass: XCTestCase {
    func loadJSONData(filename: String) -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
}
