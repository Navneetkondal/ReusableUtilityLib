//
//  SecureView.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 24/06/26.
//

import SwiftUI
import UIKit
import AppUIKIT

public struct SecureView<Content: View>: UIViewRepresentable {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public func makeUIView(context: Context) ->  SecureContainerView {
        let secureView = SecureContainerView()
        let hostingController = UIHostingController(rootView: content)
        
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    
        secureView.addSubview( hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: secureView.contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: secureView.contentView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: secureView.contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: secureView.contentView.trailingAnchor)
        ])
        return secureView
    }
    
    public func updateUIView(_ uiView: SecureContainerView,context: Context) {
        //
    }
}
