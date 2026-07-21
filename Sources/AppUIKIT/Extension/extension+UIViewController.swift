//
//  extension+UIViewController.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 24/06/26.
//
import UIKit

public extension UIViewController {
    
    /// Enable screenshot & screen recording protection
    func enableScreenSecurity(blurStyle: UIBlurEffect.Style = .systemUltraThinMaterialDark) {
        ScreenSecurityManager.shared.startProtection(blurStyle: blurStyle)
    }
    
    /// Disable screenshot & screen recording protection
    func disableScreenSecurity() {
        ScreenSecurityManager.shared.stopProtection()
    }
    
    /// Enable screenshot protection
    func applyScreenshotProtection() {
        applyScreenshotProtection(view)
    }
    
    /// Enable screenshot protection
    func applyScreenshotProtection(_ view: UIView) {
        let secureContainer = SecureContainerView()
        secureContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let existingSubviews = view.subviews
        view.addSubview(secureContainer)
        
        NSLayoutConstraint.activate([
            secureContainer.topAnchor.constraint(equalTo: view.topAnchor),
            secureContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secureContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secureContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        existingSubviews.forEach { secureContainer.contentView.addSubview($0) }
    }
}
