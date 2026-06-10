//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 08/04/26.
//

import Foundation

public enum KCClassType: RawRepresentable, CaseIterable{
    public typealias RawValue = CFString
    case genericPassword
    case internetPassword
    case certificate
    case cryptography
    case identity
    
    public var rawValue: CFString {
        switch self {
            case .genericPassword:
                return kSecClassGenericPassword
            case .internetPassword:
                return kSecClassInternetPassword
            case .certificate:
                return kSecClassCertificate
            case .cryptography:
                return kSecClassKey
            case .identity:
                return kSecClassIdentity
        }
    }
    
    public init?(rawValue: CFString) {
        switch rawValue {
            case kSecClassGenericPassword:
                self = .genericPassword
            case kSecClassInternetPassword:
                self = .internetPassword
            case kSecClassCertificate:
                self = .certificate
            case kSecClassKey:
                self = .cryptography
            case kSecClassIdentity:
                self = .identity
            default:
                return nil
        }
    }
}
