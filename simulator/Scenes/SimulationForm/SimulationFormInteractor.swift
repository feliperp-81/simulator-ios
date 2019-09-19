//
//  SimulationFormInteractor.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

protocol SimulationFormBusinessLogic {
    func handleSimulation()
}

class SimulationFormInteractor: SimulationFormBusinessLogic {
    var presenter: SimulationFormPresentationLogic?

    func handleSimulation() {
        presenter?.showSimulationDetail()
    }
}
