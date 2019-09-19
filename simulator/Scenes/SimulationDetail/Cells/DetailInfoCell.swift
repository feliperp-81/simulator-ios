//
//  DetailInfoCell.swift
//  simulator
//
//  Created by Felipe Rodrigues on 17/09/19.
//

import UIKit

class DetailInfoCell: UITableViewCell {
    static var identifier = "DetailInfoCell"
    static var height: CGFloat = 30
    static var emptyHeight: CGFloat = 45

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!

    func updateInfo(with object: FetchSimulation.ViewObject) {
        titleLabel.text = object.title
        valueLabel.text = object.value
    }
}
