//
//  SimulationDetailAPIWorker.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import Foundation

protocol SimulationDetailAPIWorkerProtocol {
    func fetchSimulation(request: FetchSimulation.Request, callback: @escaping (SimulationModel?) -> Void)
}

class SimulationDetailAPIWorker: SimulationDetailAPIWorkerProtocol {
    private var dataTask: URLSessionTask?
    private var path = "/calculator/simulate"

    func fetchSimulation(request: FetchSimulation.Request, callback: @escaping (SimulationModel?) -> Void) {
        guard let url = Endpoint(path: path, parameters: request.toDictionary()).url else {
            DispatchQueue.main.async { callback(nil) }
            return
        }

        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: url) { data, response, _ in
            let response = ResponseHandler<SimulationModel>(data: data, httpResponse: response as? HTTPURLResponse)
            let result = response.getModel()

            DispatchQueue.main.async { callback(result) }
        }
        dataTask?.resume()
    }
}
