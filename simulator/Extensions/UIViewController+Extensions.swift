//
//  UIAlertController+Extensions.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import UIKit

extension UIViewController {
    public func showRetryAlert(
        message: String, retryAction: @escaping (() -> Void), cancelAction: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

        let retryAction = UIAlertAction(title: "Tentar Novamente", style: .default) { _ in
            DispatchQueue.main.async {
                retryAction()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive) { _ in
            DispatchQueue.main.async {
                cancelAction()
            }
        }

        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}
