//
//  SimulationDetailModels.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

enum FetchSimulation {
    struct Request {
        let investedAmount: Double
        let index: String = "CDI"
        let rate: Double
        let isTaxFree: Bool = false
        let maturityDate: String
    }

    struct Response {
        var simulation: SimulationModel?
    }

    struct ViewObject {
        let title: String?
        let value: String?

        var isEmpty: Bool {
            return title == nil && value == nil
        }
    }

    struct ViewObjectList {
        var list: [ViewObject]
    }

    struct HeaderViewObject {
        let total: String
        let earnings: String
    }
}

extension FetchSimulation.Request {
    func toDictionary() -> [String: String] {
        return [
            "investedAmount": "\(investedAmount)",
            "index": index,
            "rate": "\(rate)",
            "isTaxFree": "\(isTaxFree)",
            "maturityDate": maturityDate
        ]
    }
}
