//
//  SimulationFormPresenter.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

protocol SimulationFormPresentationLogic {
    func showSimulationDetail()
}

class SimulationFormPresenter: SimulationFormPresentationLogic {
    weak var viewController: SimulationFormDisplayLogic?

    func showSimulationDetail() {
        viewController?.displaySimulationDetail()
    }
}
