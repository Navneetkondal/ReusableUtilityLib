//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 08/04/26.
//

import Foundation
import UIKit

public extension UITableView {
    
    /// Register cell
    /// - Parameters:
    ///   - _:  UITableViewCell Type
    ///   - indentifier: Cell Indentifier
    func register<T: UITableViewCell>(_: T.Type, withIdentifier indentifier: String? = nil){
        /**
         example:
         tableView.register(TableViewCell.self)
         */
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
        register(nib, forCellReuseIdentifier:  indentifier ?? String(describing: T.self))
    }
    
    ///  Register Header and Footer View (Conforms to UITableViewHeaderFooterView)
    /// - Parameters:
    ///   - _: UITableViewHeaderFooterView Type
    ///   - indentifier: Cell Indentifier
    func register<T: UITableViewHeaderFooterView>(_: T.Type , withIdentifier indentifier: String? = nil){
        /**
         example:
         tableView.register(HeaderFooterView.self)
         */
        let nib = UINib(nibName: String(describing: T.self), bundle: Bundle(for: T.self))
        register(nib, forHeaderFooterViewReuseIdentifier: indentifier ?? String(describing: T.self))
    }
    
    /// To dequeue Header Footer View
    /// - Parameter indentifier: Cell Indentifier
    /// - Returns: UITableViewCell Type
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withIdentifier indentifier: String? = nil) -> T{
        /**
         example:
         let headerFooterView: HeaderFooterView = tableView.dequeueReusableHeaderFooterView()
         */
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier:indentifier ?? String(describing: T.self)) as? T else {
            fatalError("Could not dequeue Header/Footer with identifier: \(indentifier ?? String(describing: T.self))")
        }
        return headerFooter
    }
    
    /// To dequeue Tableview cell
    /// - Parameter indentifier: Cell Indentifier
    /// - Parameter indexPath: Cell IndexPath
    /// - Returns: UITableViewCell Type
    func dequeueReusableCell<T: UITableViewCell>(cellForRowAt indexPath: IndexPath , withIdentifier indentifier: String? = nil) -> T {
        /**
         example:
         let cell: TableCell = tableView.dequeueReusableCell(cellForRowAt: indexPath)
         */
        return dequeueReusableCell(withIdentifier: indentifier ??  "\(T.self)" , for: indexPath) as! T
    }
    
    /// To dequeue Tableview cell
    /// - Parameter indentifier: Cell Indentifier
    /// - Returns: UITableViewCell Type
    func dequeueReusableCell<T: UITableViewCell>(withIdentifier indentifier: String? = nil) -> T {
        /**
         example:
         let cell: TableCell = tableView.dequeueReusableCell()
         */
        return dequeueReusableCell(withIdentifier: indentifier ??  "\(T.self)") as! T
    }
}

extension ReusableKeyboardHandelerDelegate where Self : UITableView {
    @MainActor
    public func fitContentInset(inset:UIEdgeInsets!){
        self.contentInset = inset
        self.scrollIndicatorInsets = inset
    }
}
