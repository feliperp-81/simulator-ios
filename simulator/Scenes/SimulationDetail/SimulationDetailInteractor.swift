//
//  SimulationDetailInteractor.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

protocol SimulationDetailBusinessLogic {
    func fetchSimulation(request: FetchSimulation.Request)
}

class SimulationDetailInteractor: SimulationDetailBusinessLogic {
    private var simulation: SimulationModel?
    private let worker: SimulationDetailAPIWorkerProtocol

    var presenter: SimulationDetailPresentationLogic?

    required init(withWorker worker: SimulationDetailAPIWorkerProtocol = SimulationDetailAPIWorker()) {
        self.worker = worker
    }

    func fetchSimulation(request: FetchSimulation.Request) {
        worker.fetchSimulation(request: request) { [unowned self] simulation in
            self.simulation = simulation

            if simulation == nil {
                self.presenter?.presentError(message: "Não foi possível fazer a simulação.")
            } else {
                let response = FetchSimulation.Response(simulation: simulation)
                self.presenter?.presentSimulation(response: response)
            }
        }
    }
}
