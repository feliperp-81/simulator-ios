//
//  ViewController.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import UIKit

protocol SimulationFormDisplayLogic: class {
    func displaySimulationDetail()
}

class SimulationFormViewController: UIViewController {
    var interactor: SimulationFormBusinessLogic?
    var router: SimulationFormRouter?
    var requestItem: FetchForms.Request?

    @IBOutlet weak var dateTextField: CustomTextField!
    @IBOutlet weak var rateTextField: CustomTextField!
    @IBOutlet weak var valueTextField: CustomTextField!
    @IBOutlet weak var simulateButton: UIButton!

    private var isAllFieldsValid: Bool = false {
        didSet {
            let color = isAllFieldsValid ? Colors.cyan : Colors.lightGray
            simulateButton.isEnabled = isAllFieldsValid
            simulateButton.backgroundColor = color
        }
    }

    private let maxCharsInValueTextField = 20
    private let maxCharsInDateTextField = 10
    private let maxCharsInRateTextField = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTextFields()
    }

    @IBAction func clearAllAction(_ sender: Any) {
        valueTextField.text = nil
        dateTextField.text = nil
        rateTextField.text = nil

        isAllFieldsValid = false
        valueTextField.becomeFirstResponder()
    }

    @IBAction func simulateAction(_ sender: Any) {
        interactor?.handleSimulation()
    }

    @IBAction func textFieldValueChanged(_ textField: UITextField) {
        if textField == valueTextField {
            guard let text = textField.text?.toCurrencyInputFormat else { return }
            textField.text = text
        } else  if textField == dateTextField {
            guard let text = textField.text?.toDateInputFormat else { return }
            textField.text = text
        } else if textField == rateTextField {
            guard let text = textField.text?.toPercentInputFormat else { return }
            textField.text = text
        }

        validateFields()
    }

    private func setup() {
        let viewController = self
        let interactor = SimulationFormInteractor()
        let presenter = SimulationFormPresenter()
        let router = SimulationFormRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }

    private func setupTextFields() {
        valueTextField.title = "Quanto você gostaria de aplicar?*"
        valueTextField.placeholder = "R$"

        dateTextField.title = "Qual a data de vencimento do investimento?*"
        dateTextField.placeholder = "dia/mês/ano"

        rateTextField.title = "Qual o percentual do CDI do investimento?*"
        rateTextField.placeholder = "100%"
    }

    private func validateFields() {
        guard
            let value = valueTextField.text?.toDouble,
            let date = dateTextField.text?.toDate, date > Date(),
            let rate = rateTextField.text?.toPercent
        else {
            isAllFieldsValid = false
            requestItem = nil
            return
        }

        let dateText = DateFormatter.requestDateFormatter.string(from: date)
        requestItem = FetchForms.Request(investmentValue: value, dateValue: dateText, rateValue: rate)
        isAllFieldsValid = true
    }
}

// MARK: - SimulationFormDisplayLogic -

extension SimulationFormViewController: SimulationFormDisplayLogic {
    func displaySimulationDetail() {
        guard let request = requestItem else { return }
        router?.routeToSimulationDetail(request: request)
    }
}

// MARK: - UITextFieldDelegate -
extension SimulationFormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)
        -> Bool {
        let text: NSString = (textField.text ?? "") as NSString
        let finalString = text.replacingCharacters(in: range, with: string)

        if textField == valueTextField && finalString.count > maxCharsInValueTextField {
            return false
        } else if textField == dateTextField && finalString.count > maxCharsInDateTextField {
            return false
        } else if textField == rateTextField && finalString.count > maxCharsInRateTextField {
            return false
        }

        if textField == rateTextField && string.isEmpty {
            let text = (textField.text?.dropLast() ?? "") as NSString
            let newRange = NSRange(location: range.location, length: range.length - 1)
            rateTextField.text = text.replacingCharacters(in: newRange, with: string)
        }

        return true
    }
}
