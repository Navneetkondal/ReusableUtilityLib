//
//  UIKITControllerPreview.swift
//  ReusableLib
//
//  Created by Navneet on 01/04/26.
//

import UIKit
import SwiftUI

public struct UIKITControllerPreview<controller: UIViewController>: UIViewControllerRepresentable{
    
    let viewController: UIViewController
    
    public init(_ builder: @escaping () -> UIViewController) {
        viewController = builder()
    }
    
    // MARK: - UIViewControllerRepresentable
    public func makeUIViewController(context: Context) -> UIViewController {
        viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

// Example:
//#Preview{
//    UIKITControllerPreview{
//        ViewController()
//    }
//}
