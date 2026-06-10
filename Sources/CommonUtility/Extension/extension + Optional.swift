//
//  extension + Date.swift
//  SwiftUIReusable
//
//  Created by Navneet on 1/05/25.
//


import Foundation
import UIKit

extension Optional where Wrapped == Int {
    ///Return `Wrapped` or `Default Value`
    public var orDefault: Int {
        return self ??  0
    }
    
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

extension Optional where Wrapped == String {
    ///Return `Wrapped` or `Default Value`
    public var orDefault: String {
        return self ?? ""
    }
    
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

extension Optional where Wrapped == Double {
    ///Return `Wrapped` or `Default Value`
    public var orDefault: Double {
        return self ?? 0.0
    }
    
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

extension Optional where Wrapped == Float {
    ///Return `Wrapped` or `Default Value`
    public var orDefault: Float {
        return self ?? 0.0
    }
    
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

extension Optional where Wrapped == Bool {
    ///Return `Wrapped` or `Default Value`
    public var orDefault: Bool {
        return self ?? false
    }
    
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

extension Optional where Wrapped == Int32 {
    ///Return `Wrapped` or `Default value`
    public var orDefault: Int32 {
        return self ??  0
    }
    
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

extension Optional where Wrapped == Int64 {
    ///Return `Wrapped` or `Default Value`
    public var orDefault: Int64 {
        return self ?? 0
    }
    
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

@available(iOS 18.0, *)
extension Optional where Wrapped == Int128 {
    ///Return `Wrapped` or `Default Value`
    public var orDefault: Int128 {
        return self ?? 0
    }
    
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

extension Optional where Wrapped == Character {
    ///Return `Wrapped` or `Default Value`
    public var orDefault: Character {
        return self ?? Character("")
    }
    
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

extension Optional where Wrapped: Collection {
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

extension Optional where Wrapped: UIView {
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

extension Optional where Wrapped: UIViewController {
    /// Return Bool When `Wrapped` value is nil or empty
    public var isNilOrEmpty: Bool {
        return self == nil
    }
}

/// To Use with custom data models
///  Example:
///  class EmployeeData{
///    var name: String!
///  }
///
///extension Optional: DefaultOptionalValueProtocol where Wrapped == EmployeeData && {
///associatedtype type = EmployeeData
///public var orDefault: EmployeeData {
///    return self ?? EmployeeData()
///}
///}
///
public protocol DefaultOptionalValueProtocol{
    associatedtype type
    var orDefault: type{ get  }
}
