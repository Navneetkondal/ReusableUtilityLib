//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 08/04/26.
//

import Foundation
import UIKit

@MainActor
public protocol InitStoryboardProtocol{
    /// InitiateStoryboard
    /// - Parameter bundle: Bundle id of UIViewController
    /// - Returns: UIStoryboard
    func initantiateStoryboard(for bundle: Bundle) -> UIStoryboard
}

extension InitStoryboardProtocol where Self: RawRepresentable, Self.RawValue == String{
    public func initantiateStoryboard(for bundle: Bundle) -> UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: bundle)
    }
}

public extension UIViewController{
    
    /// Initiate viewcontroller with storyboard
    /// - Parameter storyboard: storyboard Name
    /// - Returns: Viewcontroller
    class func initController<T : InitStoryboardProtocol>(with storyboard : T)  -> Self? {
        //TODO: Need to validate case when we make a class in foundation and storyboard in Main project
        return storyboard.initantiateStoryboard(for: Bundle(for: self)).instantiateViewController(withIdentifier: "\(self)") as? Self
    }
}


//Example:
//enum StoryboardConstant: String, InitStoryboardProtocol{
//    case menu = "Menu"
//}
//extension UIViewController {
//    class func initUsingPOStoryboard(storyboard : StoryboardConstant) -> Self {
//        return initController(with: storyboard)!
//    }
//}
