//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 08/04/26.
//

import Foundation
import UIKit

extension UIScrollView: @MainActor ReusableKeyboardHandelerDelegate{ }

public extension ReusableKeyboardHandelerDelegate where Self : UIScrollView {
    @MainActor func fitContentInset(inset:UIEdgeInsets!){
        self.contentInset = inset
        self.scrollIndicatorInsets = inset
    }
}
