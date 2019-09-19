//
//  SimulationDetailSceneTests.swift
//  simulatorTests
//
//  Created by Felipe Rodrigues on 18/09/19.
//

import XCTest
@testable import simulator

class SimulationDetailSceneTests: BaseTestClass {
    var mock: SimulationModel!

    override func setUp() {
        super.setUp()
        guard
            let data = loadJSONData(filename: "resultOK"),
            let mock = try? SimulationModel(with: data)
        else {
            XCTFail("couldn't load json file or parse it")
            return
        }

        self.mock = mock
    }

    func testInteractorFetchSimulation() {
        // Given
        let workerSpy = SimulationDetailWorkerSpy(mock: mock)
        let sut = SimulationDetailInteractor(withWorker: workerSpy)
        // When
        let request = FetchSimulation.Request(investedAmount: 1.000, rate: 123, maturityDate: "03-03-2020")
        sut.fetchSimulation(request: request)
        // Then
        XCTAssert(workerSpy.fetchSimulationCalled, "fetchSimulation() should ask the worker to fetch simulation")
    }

    func testInteractorCallPresentSimulation() {
        // Given
        let presenterSpy = SimulationDetailPresentSpy()
        let workerSpy = SimulationDetailWorkerSpy(mock: mock)
        let sut = SimulationDetailInteractor(withWorker: workerSpy)
        sut.presenter = presenterSpy
        // When
        let request = FetchSimulation.Request(investedAmount: 1.000, rate: 123, maturityDate: "03-03-2020")
        sut.fetchSimulation(request: request)
        // Then
        XCTAssert(presenterSpy.presentSimulationCalled,
                  "fetchSimulation() should ask the presenter to format the simulation")
    }

    func testInteractorCallPresentErrorSimulation() {
        // Given
        let presenterSpy = SimulationDetailPresentSpy()
        let workerSpy = SimulationDetailWorkerSpy(mock: nil)
        let sut = SimulationDetailInteractor(withWorker: workerSpy)
        sut.presenter = presenterSpy
        // When
        let request = FetchSimulation.Request(investedAmount: 1.000, rate: 123, maturityDate: "03-03-2020")
        sut.fetchSimulation(request: request)
        // Then
        XCTAssert(presenterSpy.presentErrorCalled, "fetchSimulation() should ask the presenter to call error")
    }

    func testDisplayListAndHeaderCalledByPresenter() {
        // Given
        let viewControllerSpy = ViewControllerSpy()
        let sut = SimulationDetailPresenter()
        sut.viewController = viewControllerSpy
        // When
        sut.presentSimulation(response: FetchSimulation.Response(simulation: mock))
        // Then
        XCTAssert(viewControllerSpy.displaySimulationListCalled,
                  "presnetSimulation() should ask the viewController to display list")
        XCTAssert(viewControllerSpy.displaySimulationHeaderCalled,
                  "presnetSimulation() should ask the viewController to display header")
    }

    func testDisplayErrorCalledByPresenter() {
        // Given
        let viewControllerSpy = ViewControllerSpy()
        let sut = SimulationDetailPresenter()
        sut.viewController = viewControllerSpy
        // When
        sut.presentError(message: "erro")
        // Then
        XCTAssert(viewControllerSpy.displayErrorCalled, "presentError() should ask the viewController to display error")
    }
}

// MARK: - Simulation Detail Spies -

extension SimulationDetailSceneTests {
    class SimulationDetailPresentSpy: SimulationDetailPresentationLogic {
        var presentSimulationCalled = false
        var presentErrorCalled = false
        var response: FetchSimulation.Response?

        func presentError(message: String) {
            presentErrorCalled = true
        }

        func presentSimulation(response: FetchSimulation.Response) {
            presentSimulationCalled = true
            self.response = response
        }
    }

    class SimulationDetailWorkerSpy: SimulationDetailAPIWorkerProtocol {
        var fetchSimulationCalled = false
        let model: SimulationModel?

        init(mock: SimulationModel?) {
            model = mock
        }

        func fetchSimulation(request: FetchSimulation.Request, callback: @escaping (SimulationModel?) -> Void) {
            fetchSimulationCalled = true
            callback(model)
        }
    }

    class ViewControllerSpy: SimulationDetailDisplayLogic {
        var displaySimulationListCalled = false
        var displaySimulationHeaderCalled = false
        var displayErrorCalled = false

        func displaySimulationList(viewObjectList: FetchSimulation.ViewObjectList) {
            displaySimulationListCalled = true
        }

        func displaySimulationHeader(headerViewObject: FetchSimulation.HeaderViewObject) {
            displaySimulationHeaderCalled = true
        }

        func displayError(message: String) {
            displayErrorCalled = true
        }
    }
}
