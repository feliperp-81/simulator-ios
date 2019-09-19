//
//  SimulationDetailPresenter.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

protocol SimulationDetailPresentationLogic {
    func presentSimulation(response: FetchSimulation.Response)
    func presentError(message: String)
}

class SimulationDetailPresenter: SimulationDetailPresentationLogic {
    weak var viewController: SimulationDetailDisplayLogic?

    func presentSimulation(response: FetchSimulation.Response) {
        guard let simulation = response.simulation else { return }

        var viewObjectList = [FetchSimulation.ViewObject]()
        let initialValue = simulation.investmentParameter.investedAmount.toCurrency
        let grossValue = simulation.grossAmount.toCurrency
        let earnings = (simulation.grossAmount - simulation.investmentParameter.investedAmount).toCurrency
        let netValue = simulation.netAmount.toCurrency
        let maturityDate = DateFormatter.UIDateFormatter.string(from: simulation.investmentParameter.maturityDate)
        let taxesValue = simulation.taxesAmount.toCurrency
        let taxesRate = simulation.taxesRate.toPercentual
        let grossRateProfit = simulation.monthlyGrossRateProfit.toPercentual
        let rateValue = simulation.investmentParameter.rate.toPercentual
        let annualGrossRateProfit = simulation.annualGrossRateProfit.toPercentual
        let rateProfit = simulation.rateProfit.toPercentual

        let headerObject = FetchSimulation.HeaderViewObject(total: "\(grossValue)", earnings: "\(earnings)")

        viewObjectList.append(FetchSimulation.ViewObject(title: "Valor aplicado inicialmente", value: initialValue))
        viewObjectList.append(FetchSimulation.ViewObject(title: "Valor bruto do investimento", value: grossValue))
        viewObjectList.append(FetchSimulation.ViewObject(title: "Valor do rendimento", value: earnings))
        viewObjectList.append(FetchSimulation.ViewObject(title: "IR sobre o investimento",
                                                         value: "\(taxesValue)(\(taxesRate))"))
        viewObjectList.append(FetchSimulation.ViewObject(title: "Valor líquido do investimento", value: netValue))
        viewObjectList.append(FetchSimulation.ViewObject(title: nil, value: nil))
        viewObjectList.append(FetchSimulation.ViewObject(title: "Data do Resgate", value: "\(maturityDate)"))
        viewObjectList.append(FetchSimulation.ViewObject(title: "Dias corridos",
                                                         value: "\(simulation.investmentParameter.maturityTotalDays)"))
        viewObjectList.append(FetchSimulation.ViewObject(title: "Rendimento mensal", value: grossRateProfit))
        viewObjectList.append(FetchSimulation.ViewObject(title: "Percentual do CDI do investimento",
                                                         value: "\(rateValue)"))
        viewObjectList.append(FetchSimulation.ViewObject(title: "Rentabilidade anual", value: annualGrossRateProfit))
        viewObjectList.append(FetchSimulation.ViewObject(title: "Rentabilidade no período", value: rateProfit))

        viewController?.displaySimulationHeader(headerViewObject: headerObject)
        viewController?.displaySimulationList(viewObjectList: FetchSimulation.ViewObjectList(list: viewObjectList))
    }

    func presentError(message: String) {
        viewController?.displayError(message: message)
    }
}
