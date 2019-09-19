//
//  DateFormatter+Extensions.swift
//  simulator
//
//  Created by Felipe Rodrigues on 18/09/19.
//

import Foundation

extension DateFormatter {
    static let UIDateFormatter = DateFormatter.formatterWith(format: "dd/MM/yyyy")
    static let requestDateFormatter = DateFormatter.formatterWith(format: "yyyy-MM-dd")
    static let serverDateFormatter = DateFormatter.formatterWith(format: "yyyy-MM-dd'T'HH:mm:ss")

    class func formatterWith(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
