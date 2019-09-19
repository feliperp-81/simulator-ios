//
//  String+Extensions.swift
//  simulator
//
//  Created by Felipe Rodrigues on 18/09/19.
//

import Foundation
import TLCustomMask

extension String {
    var toCurrencyInputFormat: String {
        var amountWithPrefix = self
        guard let regex = try? NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive) else { return "" }

        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                          options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                          range: NSRange(location: 0, length: self.count),
                                                          withTemplate: "")

        guard let double = Double(amountWithPrefix) else { return "" }
        let value = (double / 100)

        if value == 0 {
            return ""
        }

        return value.toCurrency
    }

    var toDateInputFormat: String {
        let customMask = TLCustomMask(formattingPattern: "$$/$$/$$$$")
        return customMask.formatString(string: self)
    }

    var toPercentInputFormat: String {
        if self.isEmpty {
            return self
        }
        return "\(self.replacingOccurrences(of: "%", with: ""))%"
    }

    var toDate: Date? {
        return DateFormatter.UIDateFormatter.date(from: self)
    }

    var toDouble: Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 2
        return formatter.number(from: self)?.doubleValue
    }

    var toPercent: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self.replacingOccurrences(of: "%", with: ""))?.doubleValue
    }

    var toServerDate: Date? {
        let formatter = DateFormatter.serverDateFormatter
        return formatter.date(from: self)
    }
}
