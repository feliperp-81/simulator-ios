//
//  SimulationFormRouter.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

protocol SimulationFormRoutingLogic {
    func routeToSimulationDetail(request: FetchForms.Request)
}

class SimulationFormRouter: SimulationFormRoutingLogic {
    weak var viewController: SimulationFormViewController?

    // MARK: - Routing -
    func routeToSimulationDetail(request: FetchForms.Request) {
        guard let destinationVC = viewController?.storyboard?.instantiateViewController(
            withIdentifier: "SimulationDetailVC") as? SimulationDetailViewController else {
            return
        }

        destinationVC.request = FetchSimulation.Request(investedAmount: request.investmentValue,
                                                        rate: request.rateValue, maturityDate: request.dateValue)

        navigateToSimulationDetail(destinationVC: destinationVC)
    }

    // MARK: - Navigation -
    private func navigateToSimulationDetail(destinationVC: SimulationDetailViewController) {
        viewController?.show(destinationVC, sender: nil)
    }
}
