//
//  extension+CALayer.swift
//  UIKITBasic
//
//  Created by Navneet on 22/01/26.
//

import Foundation
import UIKit

extension CALayer{
    
    func setCornerCurve(_ radius: CGFloat, corners: MaskedCorners){
        self.maskedCorners = corners.value
        self.cornerRadius = radius
        self.masksToBounds = true
    }
    
    enum MaskedCorners: Int {
        case topLeft, topRight, bottomLeft, bottomRight
        case top, bottom
        case leading, trailing
        var value: CACornerMask {
            switch self {
                case .topLeft: return [.layerMinXMinYCorner]
                case .topRight: return [.layerMaxXMinYCorner]
                case .bottomLeft: return [.layerMinXMaxYCorner]
                case .bottomRight: return [.layerMaxXMaxYCorner]
                case .top: return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                case .bottom: return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                case .leading: return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                case .trailing: return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            }
        }
    }
}
