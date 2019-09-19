//
//  Collection+Extensions.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

extension Collection {
    func get(at index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
