//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 08/04/26.
//

import Foundation
import UIKit

@MainActor
public extension UICollectionView {
    
    enum SupplementaryViewKind: String {
        case header
        case footer
        
        public var rawValue: String {
            switch self {
                case .header:
                    return UICollectionView.elementKindSectionHeader
                case .footer:
                    return UICollectionView.elementKindSectionFooter
            }
        }
    }
    
    /// Register cell
    /// - Parameters:
    ///   - _:  UICollectionViewCell Type
    ///   - indentifier: Cell Indentifier
    func register<T: UICollectionViewCell>(_: T.Type, withIdentifier indentifier: String? = nil){
        /**
         example:
         collectionView.register(CollectionViewCell.self)
         */
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
        register(nib, forCellWithReuseIdentifier: indentifier ?? String(describing: T.self))
    }
    
    ///  Register Header and Footer View (Conforms to UITableViewHeaderFooterView)
    /// - Parameters:
    ///   - _: UICollectionReusableView Type
    ///   - indentifier: Cell Indentifier
    func register<T: UICollectionReusableView>(_: T.Type, forSupplementaryViewOfKind kind: SupplementaryViewKind, withIdentifier identifier: String? = nil) {
        /**
         example:
         collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
         collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
         */
        let nib = UINib(nibName: String(describing: T.self), bundle: Bundle(for: T.self))
        register(nib, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: identifier ?? String(describing: T.self))
    }
    
    // Dequeue Reusable Header and Footer View
    /// To dequeue Header Footer View
    /// - Parameter indentifier: Cell Indentifier
    /// - Returns: UICollectionReusableView Type
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: SupplementaryViewKind, for indexPath: IndexPath, withReuseIdentifier identifier: String? = nil) -> T {
        /**
         example:
         let headerView: HeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
         let footerView: FooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath)
         */
        let reuseIdentifier = identifier ?? String(describing: T.self)
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(reuseIdentifier)")
        }
        return supplementaryView
    }
    
    /// To dequeue Tableview cell
    /// - Parameter indentifier: Cell Indentifier
    /// - Parameter indexPath: Cell IndexPath
    /// - Returns: UICollectionViewCell Type
    func dequeueReusableCell<T: UICollectionViewCell>(cellForRowAt indexPath: IndexPath , withIdentifier indentifier: String? = nil) -> T {
        /**
         example:
         let cell: CollectionCell = collectionView.dequeueReusableCell(cellForRowAt: indexPath)
         */
        return dequeueReusableCell(withReuseIdentifier: indentifier ??  "\(T.self)" , for: indexPath) as! T
    }
}

public extension ReusableKeyboardHandelerDelegate where Self : UICollectionView {
    @MainActor func fitContentInset(inset:UIEdgeInsets!){
        self.contentInset = inset
        self.scrollIndicatorInsets = inset
    }
}
