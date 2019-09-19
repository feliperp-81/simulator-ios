//
//  simulatorTests.swift
//  simulatorTests
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import XCTest
@testable import simulator

class SimulationModelTests: BaseTestClass {
    var mock: SimulationModel!

    override func setUp() {
        super.setUp()
        let maturityDate = "2023-03-03T00:00:00".toServerDate ?? Date()
        let investmentParameter = InvestmentParameter(investedAmount: 32323, yearlyInterestRate: 6.535,
                                                      maturityTotalDays: 1263, maturityBusinessDays: 897,
                                                      maturityDate: maturityDate, rate: 123, isTaxFree: false)

        mock = SimulationModel(investmentParameter: investmentParameter,
                               grossAmount: 42645.72,
                               taxesAmount: 1548.41,
                               netAmount: 41097.31,
                               grossAmountProfit: 10322.72,
                               netAmountProfit: 8774.31,
                               annualGrossRateProfit: 31.94,
                               monthlyGrossRateProfit: 0.53,
                               dailyGrossRateProfit: 0.000309019613084349,
                               taxesRate: 15,
                               rateProfit: 6.535,
                               annualNetRateProfit: 27.15)
    }

    func testParseSimulationModel() {
        guard let data = loadJSONData(filename: "resultOK") else {
            XCTFail("couldn't load json file")
            return
        }

        do {
            _ = try SimulationModel(with: data)
            XCTAssert(true)
        } catch {
            XCTAssert(false, "\(error)")
        }
    }

    func testParsedValues() {
        guard let data = loadJSONData(filename: "resultOK") else {
            XCTFail("couldn't load json file")
            return
        }

        do {
            let model = try SimulationModel(with: data)

            XCTAssertTrue(model.investmentParameter.investedAmount == mock.investmentParameter.investedAmount)
            XCTAssertTrue(model.investmentParameter.yearlyInterestRate == mock.investmentParameter.yearlyInterestRate)
            XCTAssertTrue(model.investmentParameter.maturityTotalDays == mock.investmentParameter.maturityTotalDays)
            XCTAssertTrue(
                model.investmentParameter.maturityBusinessDays == mock.investmentParameter.maturityBusinessDays)
            XCTAssertTrue(model.investmentParameter.maturityDate == mock.investmentParameter.maturityDate)
            XCTAssertTrue(model.investmentParameter.rate == mock.investmentParameter.rate)
            XCTAssertTrue(model.investmentParameter.isTaxFree == mock.investmentParameter.isTaxFree)
            XCTAssertTrue(model.grossAmount == mock.grossAmount)
            XCTAssertTrue(model.taxesAmount == mock.taxesAmount)
            XCTAssertTrue(model.netAmount == mock.netAmount)
            XCTAssertTrue(model.netAmountProfit == mock.netAmountProfit)
            XCTAssertTrue(model.annualGrossRateProfit == mock.annualGrossRateProfit)
            XCTAssertTrue(model.monthlyGrossRateProfit == mock.monthlyGrossRateProfit)
            XCTAssertTrue(model.dailyGrossRateProfit == mock.dailyGrossRateProfit)
            XCTAssertTrue(model.taxesRate == mock.taxesRate)
            XCTAssertTrue(model.rateProfit == mock.rateProfit)
            XCTAssertTrue(model.annualNetRateProfit == mock.annualNetRateProfit)
        } catch {
            XCTAssert(false, "\(error)")
        }
    }

    func testParseError() {
        guard let data = loadJSONData(filename: "resultError") else {
            XCTFail("couldn't load json file")
            return
        }

        do {
            _ = try SimulationModel(with: data)
            XCTFail("shouldn't have parsed the info")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
