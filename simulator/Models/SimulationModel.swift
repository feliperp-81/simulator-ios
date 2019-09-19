//
//  SimulationResult.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

struct SimulationModel: Decodable {
    let investmentParameter: InvestmentParameter
    let grossAmount: Double
    let taxesAmount: Double
    let netAmount: Double
    let grossAmountProfit: Double
    let netAmountProfit: Double
    let annualGrossRateProfit: Double
    let monthlyGrossRateProfit: Double
    let dailyGrossRateProfit: Double
    let taxesRate: Double
    let rateProfit: Double
    let annualNetRateProfit: Double
}

struct InvestmentParameter: Decodable {
    let investedAmount: Double
    let yearlyInterestRate: Double
    let maturityTotalDays: Int
    let maturityBusinessDays: Int
    let maturityDate: Date
    let rate: Double
    let isTaxFree: Bool
}
