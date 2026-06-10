//
//  extension + Collection.swift
//  SwiftUIReusable
//
//  Created by Navneet on 31/03/26.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index?) -> Iterator.Element? {
        guard let index = index else{
            return nil
        }
        return indices.contains(index) ? self[index] : nil
    }
}

extension MutableCollection {
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
