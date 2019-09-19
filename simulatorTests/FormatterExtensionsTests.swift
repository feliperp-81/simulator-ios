//
//  FormatterExtensionsTests.swift
//  simulatorTests
//
//  Created by Felipe Rodrigues on 18/09/19.
//

import XCTest
@testable import simulator

class FormatterExtensionsTests: XCTestCase {
    func testDoubleToCurrency() {
        let doubleValue: Double = 1350.00
        XCTAssertTrue(doubleValue.toCurrency == "R$ 1.350,00")
    }

    func testDoubleToPercentual() {
        let doubleValue: Double = 50.1
        XCTAssertTrue(doubleValue.toPercentual == "50,10%")
    }

    func testStringToCurrencyInputFormat() {
        XCTAssertTrue("135".toCurrencyInputFormat == "R$ 1,35")
    }

    func testStringToDateInputFormat() {
        XCTAssertTrue("22102019".toDateInputFormat == "22/10/2019")
    }

    func testStringPercentInputFormat() {
        XCTAssertTrue("123".toPercentInputFormat == "123%")
    }

    func testStringToDate() {
        let dateString = "25/10/2010"
        XCTAssertTrue(dateString.toDate == DateFormatter.UIDateFormatter.date(from: dateString))
    }

    func testStringToDouble() {
        XCTAssertTrue("R$ 1.350,00".toDouble == 1350.00)
    }

    func testStringToPercent() {
        XCTAssertTrue("123%".toPercent == 123)
    }

    func testStringToServerDate() {
        let date = DateFormatter.serverDateFormatter.date(from: "2023-03-03T00:00:00")
        XCTAssertTrue("2023-03-03T00:00:00".toServerDate == date)
    }
}
