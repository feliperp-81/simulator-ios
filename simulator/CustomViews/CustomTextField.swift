//
//  CustomTextField.swift
//  simulator
//
//  Created by Felipe Rodrigues on 18/09/19.
//

import UIKit

enum FieldState: Int {
    case error = 0
    case normal = 1
    case warning = 2
}

class CustomTextField: UITextField {
    // MARK: - Colors
    dynamic fileprivate let placeholderColor = UIColor.gray.withAlphaComponent(0.7)
    dynamic fileprivate let titleColor = UIColor.gray
    dynamic fileprivate let lineColor = UIColor.gray.withAlphaComponent(0.7)
    dynamic fileprivate let errorColor = UIColor.red
    dynamic fileprivate let warningColor = UIColor.orange

    // MARK: - Fonts
    dynamic fileprivate let titleFont: UIFont = .systemFont(ofSize: 14.0)
    dynamic fileprivate let placeholderFont: UIFont = .systemFont(ofSize: 22.0)

    fileprivate func updatePlaceholder() {
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: placeholder,
                                                       attributes: [.foregroundColor: placeholderColor,
                                                                    .font: placeholderFont])
        }
    }

    // MARK: - Line height
    dynamic open var lineHeight: CGFloat = 1.0 {
        didSet {
            updateLineView()
            setNeedsDisplay()
        }
    }

    // MARK: - View components
    open var lineView: UIView!
    open var titleLabel: UILabel!

    // MARK: - Properties
    open var titleFormatter: ((String) -> String) = { (text: String) -> String in
        return text
    }

    dynamic open var fieldState: FieldState = .normal {
        didSet {
            updateControl(true)
        }
    }

    override open var isSecureTextEntry: Bool {
        set {
            super.isSecureTextEntry = newValue
            //            fixCaretPosition()
        }
        get {
            return super.isSecureTextEntry
        }
    }

    open var errorMessage: String? {
        didSet {
            updateControl(true)
        }
    }

    open var warningMessage: String? {
        didSet {
            updateControl(true)
        }
    }

    override open var text: String? {
        didSet {
            updateControl(false)
        }
    }

    override open var placeholder: String? {
        didSet {
            setNeedsDisplay()
            updatePlaceholder()
            updateTitleLabel()
        }
    }

    open var selectedTitle: String? {
        didSet {
            updateControl()
        }
    }

    open var title: String? {
        didSet {
            updateControl()
        }
    }

    open override var isSelected: Bool {
        didSet {
            updateControl(true)
        }
    }

    @objc
    open func editingChanged() {
        updateControl(true)
        updateTitleLabel(true)
    }

    // MARK: - Initializers
    override public init(frame: CGRect) {
        super.init(frame: frame)
        init_ETextField()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        init_ETextField()
    }

    fileprivate final func init_ETextField() {
        borderStyle = .none
        tintColor = UIColor.gray
        textColor = UIColor.gray
        createTitleLabel()
        createLineView()
        updateColors()
        setTextAlignment()
    }

    fileprivate func setTextAlignment() {
        textAlignment = .center
        titleLabel.textAlignment = .center
    }

    // MARK: - Components Creation
    fileprivate func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        addSubview(titleLabel)
        self.titleLabel = titleLabel
    }

    fileprivate func createLineView() {
        if lineView == nil {
            let lineView = UIView()
            lineView.isUserInteractionEnabled = false
            self.lineView = lineView
            configureDefaultLineHeight()
        }

        lineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(lineView)
    }

    fileprivate func configureDefaultLineHeight() {
        lineHeight = 1.0
    }

    // MARK: - Responder handling
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateControl(true)
        return result
    }

    @discardableResult
    override open func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updateControl(true)
        return result
    }

    // MARK: - View updates
    fileprivate func updateControl(_ animated: Bool = false) {
        updateColors()
        updateLineView()
        updateTitleLabel(animated)
    }

    fileprivate func updateLineView() {
        if let lineView = lineView {
            lineView.frame = lineViewRectForBounds(bounds)
        }
        updateLineColor()
    }

    // MARK: - Color updates
    open func updateColors() {
        updateLineColor()
        updateTitleColor()
        updatePlaceholder()
    }

    fileprivate func updateLineColor() {
        lineView.backgroundColor = lineColor

        if fieldState == .error {
            lineView.backgroundColor = errorColor
        } else if fieldState == .warning {
            lineView.backgroundColor = warningColor
        }
    }

    fileprivate func updateTitleColor() {
        if fieldState == .error {
            titleLabel.textColor = errorColor
        } else if fieldState == .warning {
            titleLabel.textColor = warningColor
        } else {
            titleLabel.textColor = titleColor
        }
    }

    // MARK: - Title handling
    fileprivate func updateTitleLabel(_ animated: Bool = false) {
        var titleText: String?

        if fieldState == .error {
            titleText = errorMessageOrDefautlErrorMessage()
        } else if fieldState == .warning {
            if let message = warningMessage ?? title {
                titleText = titleFormatter(message)
            }
        } else {
            titleText = titleOrPlaceholder()
        }

        titleLabel.text = titleText
        titleLabel.font = titleFont
    }

    // MARK: - UITextField text/placeholder positioning overrides
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        let titleHeight = self.titleHeight()

        return CGRect(x: superRect.origin.x, y: titleHeight, width: superRect.size.width,
                      height: superRect.size.height - titleHeight - lineHeight)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        let titleHeight = self.titleHeight()

        return CGRect(x: superRect.origin.x, y: titleHeight, width: superRect.size.width,
                      height: superRect.size.height - titleHeight - lineHeight)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: titleHeight(), width: bounds.size.width,
                      height: bounds.size.height - titleHeight() - lineHeight)
    }

    // MARK: - Positioning Overrides
    open func titleLabelRectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.size.width, height: titleHeight())
    }

    open func lineViewRectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: bounds.size.height - lineHeight, width: bounds.size.width, height: lineHeight)
    }

    open func titleHeight() -> CGFloat {
        guard let font = titleLabel.font else { return 15.0 }
        return font.lineHeight
    }

    open func textHeight() -> CGFloat {
        guard let font = self.font else { return 15.0 }
        return font.lineHeight
    }

    // MARK: - Layout
    override open func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = titleLabelRectForBounds(bounds)
        lineView.frame = lineViewRectForBounds(bounds)
    }

    override open var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height: titleHeight() + textHeight())
    }

    // MARK: - Helpers
    open func getNumberOfCharactersWithoutWhiteSpaces() -> Int {
        guard let text = text else { return 0 }
        return text.trimmingCharacters(in: .whitespacesAndNewlines).count
    }

    fileprivate func titleOrPlaceholder() -> String? {
        guard let title = title ?? placeholder else { return nil }
        return titleFormatter(title)
    }

    fileprivate func selectedTitleOrTitlePlaceholder() -> String? {
        guard let title = selectedTitle ?? title ?? placeholder else { return nil }
        return titleFormatter(title)
    }

    fileprivate func errorMessageOrDefautlErrorMessage() -> String? {
        if let message = errorMessage {
            return titleFormatter(message)
        }

        if let title = title ?? placeholder {
            return "\(title) inválido"
        }

        return "campo inválido"
    }
}
