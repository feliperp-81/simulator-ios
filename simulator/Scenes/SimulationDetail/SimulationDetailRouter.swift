//
//  SimulationDetailRouter.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

protocol SimulationDetailRoutingLogic {
    func dismiss()
}

class SimulationDetailRouter: SimulationDetailRoutingLogic {
    weak var viewController: SimulationDetailViewController?

    func dismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
