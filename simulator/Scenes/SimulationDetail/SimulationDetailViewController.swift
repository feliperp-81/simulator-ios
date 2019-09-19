//
//  SimulationDetailViewController.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import UIKit

protocol SimulationDetailDisplayLogic: class {
    func displaySimulationList(viewObjectList: FetchSimulation.ViewObjectList)
    func displaySimulationHeader(headerViewObject: FetchSimulation.HeaderViewObject)
    func displayError(message: String)
}

class SimulationDetailViewController: UIViewController {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalHeaderLabel: UILabel!
    @IBOutlet private weak var subtitleHeaderLabel: UILabel!

    var interactor: SimulationDetailBusinessLogic?
    var router: SimulationDetailRoutingLogic?
    var request: FetchSimulation.Request?

    private var items: [FetchSimulation.ViewObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchSimulation()
    }

    private func setup() {
        let viewController = self
        let interactor = SimulationDetailInteractor()
        let presenter = SimulationDetailPresenter()
        let router = SimulationDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }

    private func showLoading(isLoading: Bool) {
        tableView.isHidden = isLoading

        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    private func fetchSimulation() {
        guard let request = request else { return }
        showLoading(isLoading: true)
        interactor?.fetchSimulation(request: request)
    }

    private func getSubtitleAttributedText(value: String) -> NSAttributedString {
        let text = "Rendimento total de \(value)"
        let highlightRange = (text as NSString).range(of: value)
        let grayColorAttribute = [NSAttributedString.Key.foregroundColor: Colors.gray]
        let cyanColorAttribute = [NSAttributedString.Key.foregroundColor: Colors.cyan]

        let attributedText = NSMutableAttributedString(string: text, attributes: grayColorAttribute)
        attributedText.addAttributes(cyanColorAttribute, range: highlightRange)

        return attributedText
    }

    @IBAction private func simulateAgainAction(_ sender: Any) {
        fetchSimulation()
    }
}

// MARK: - SimulationDetailDisplayLogic -

extension SimulationDetailViewController: SimulationDetailDisplayLogic {
    func displaySimulationList(viewObjectList: FetchSimulation.ViewObjectList) {
        items = viewObjectList.list
        tableView.reloadData()
        showLoading(isLoading: false)
    }

    func displaySimulationHeader(headerViewObject: FetchSimulation.HeaderViewObject) {
        totalHeaderLabel.text = headerViewObject.total
        subtitleHeaderLabel.attributedText = getSubtitleAttributedText(value: headerViewObject.earnings)
    }

    func displayError(message: String) {
        showLoading(isLoading: false)
        showRetryAlert(message: message, retryAction: { [weak self] in
            self?.fetchSimulation()
        }, cancelAction: { [weak self] in
            self?.router?.dismiss()
        })
    }
}

// MARK: - UITableViewDataSource -

extension SimulationDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoCell.identifier,
                                                       for: indexPath) as? DetailInfoCell
        else {
            return UITableViewCell()
        }

        if let item = items.get(at: indexPath.row) {
            cell.updateInfo(with: item)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate -

extension SimulationDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = items.get(at: indexPath.row) else { return CGFloat.leastNormalMagnitude }

        if item.isEmpty {
            return DetailInfoCell.emptyHeight
        }

        return DetailInfoCell.height
    }
}
