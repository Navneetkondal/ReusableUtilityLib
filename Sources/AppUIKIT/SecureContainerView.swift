//
//  SecureContainerView.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 14/07/26.
//

import UIKit

public final class SecureContainerView: UIView {
    
    private let secureTextField = UITextField()
    
    public let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
     required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        secureTextField.isSecureTextEntry = true
        secureTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(secureTextField)
        
        NSLayoutConstraint.activate([
            secureTextField.topAnchor.constraint(equalTo: topAnchor),
            secureTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            secureTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            secureTextField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        guard let secureView = secureTextField.subviews.first else {
            return
        }
        
        secureView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: secureView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: secureView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: secureView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: secureView.trailingAnchor)
        ])
    }
}
