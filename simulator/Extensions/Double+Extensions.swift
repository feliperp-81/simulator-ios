//
//  Double+Extensions.swift
//  simulator
//
//  Created by Felipe Rodrigues on 18/09/19.
//

import Foundation

extension Double {
    var toCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 2
        return formatter.string(from: self as NSNumber) ?? ""
    }

    var toPercentual: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = ","

        let value = formatter.string(from: self as NSNumber) ?? ""
        return "\(value)%"
    }
}
