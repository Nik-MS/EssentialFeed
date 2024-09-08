//
//  ErrorView.swift
//  EssentialFeediOS
//
//  Created by Nikhil Menon on 2/20/24.
//

import UIKit

public final class ErrorView: UIButton {
    private var titleAttributes: AttributeContainer {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let attributes = AttributeContainer([
            .paragraphStyle: paragraphStyle,
            .font: UIFont.preferredFont(forTextStyle: .body),
        ])
        return attributes
    }
    
    public var onHide: (() -> Void)?
    
    public var message: String? {
        get { return isVisible ? configuration?.title : nil }
        set { setMessageAnimated(newValue) }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        var configuration = Configuration.plain()
        configuration.titlePadding = 0
        configuration.baseForegroundColor = .white
        configuration.background.backgroundColor = .errorBackgroundColor
        configuration.background.cornerRadius = 0
        configuration.contentInsets = .zero
        self.configuration = configuration
        
        addTarget(self, action: #selector(hideMessageAnimated), for: .touchUpInside)
        hideMessage()
    }
    
    private var isVisible: Bool {
        return alpha > 0
    }
    
    func hideMessage() {
        configuration?.attributedTitle = nil
        alpha = 0
        onHide?()
    }
    
    private func setMessageAnimated(_ message: String?) {
        if let message = message {
            showAnimated(message)
        } else {
            hideMessageAnimated()
        }
    }
    
    private func showAnimated(_ message: String) {
        configuration?.attributedTitle = AttributedString(message, attributes: titleAttributes)
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
    
    @objc private func hideMessageAnimated() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { completed in
            if completed { self.hideMessage() }
        }
    }
}

extension UIColor {
    static var errorBackgroundColor = UIColor(red: 0.99951404330000004, green: 0.41759261479999999, blue: 0.4154433012, alpha: 1)
}
