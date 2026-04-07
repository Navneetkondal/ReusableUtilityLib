//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 07/04/26.
//

import Foundation
import Security

public final class KCManager: NSObject{
    
    private override init() {}
    
    @discardableResult
    public class func save(service: String, key: String, value: String, classType: KCClassType, accessibleType: kCAttrAccessible) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: classType.type,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecValueData as String: value.data(using: .utf8)!,
            kSecAttrAccessible as String: accessibleType.accessibleType
        ]
        // Delete any existing item before adding to avoid conflicts
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    public class func save(service: String, key: String, value: String) -> OSStatus {
        save(service: service, key: key, value: value, classType: .genericPassword, accessibleType: .whenUnlocked)
    }
    
    @discardableResult
    public class func get(service: String, key: String, classType: KCClassType, accessibleType: kCAttrAccessible) -> Any? {
        let query: [String: Any] = [
            kSecClass as String: classType.type,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecAttrAccessible as String: accessibleType.accessibleType,
            kSecReturnData as String: true,
            kSecReturnAttributes as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        return (status == errSecSuccess) ? (result as? Data) : nil
    }
    
    @discardableResult
    public class func update(service: String, key: String, value: String, classType: KCClassType, accessibleType: kCAttrAccessible) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: classType.type,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecAttrAccessible as String: accessibleType.accessibleType
        ]
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: value.data(using: .utf8)!
        ]
        return SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    }
    
    @discardableResult
    public class func delete(service: String, key: String , classType: KCClassType, accessibleType: kCAttrAccessible) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: classType.type,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecAttrAccessible as String: accessibleType.accessibleType
        ]
        return SecItemDelete(query as CFDictionary)
    }
    
    @discardableResult
    public class func isItemExist(service: String, key: String, classType: KCClassType, accessibleType: kCAttrAccessible) -> Bool {
        // Define the search query
        let query: [String: Any] = [
            kSecClass as String: classType.type,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: false,
            kSecAttrAccessible as String: accessibleType.accessibleType
        ]
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    public enum KCClassType{
        case genericPassword
        case internetPassword
        case certificate
        case key
        case identity
        
        var type: CFString {
            switch self {
                case .genericPassword:
                    return kSecClassGenericPassword
                case .internetPassword:
                    return kSecClassInternetPassword
                case .certificate:
                    return kSecClassCertificate
                case .key:
                    return kSecClassKey
                case .identity:
                    return kSecClassIdentity
            }
        }
    }
    
    public enum kCAttrAccessible{
        case whenUnlocked
        case afterFirstUnlock
        case whenPasscodeSetThisDeviceOnly
        case whenUnlockedThisDeviceOnly
        case afterFirstUnlockThisDeviceOnly
        
        var accessibleType: CFString {
            switch self {
                case .whenUnlocked:
                    return kSecAttrAccessibleWhenUnlocked
                case .afterFirstUnlock:
                    return kSecAttrAccessibleAfterFirstUnlock
                case .whenPasscodeSetThisDeviceOnly:
                    return kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
                case .whenUnlockedThisDeviceOnly:
                    return kSecAttrAccessibleWhenUnlockedThisDeviceOnly
                case .afterFirstUnlockThisDeviceOnly:
                    return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
               
            }
        }
    }
}
