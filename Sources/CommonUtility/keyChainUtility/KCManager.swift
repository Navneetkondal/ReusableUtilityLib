//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 07/04/26.
//

import Foundation
import Security

public class KCManager: NSObject{
    
    private override init() {}
    
    //MARK: - Save
    
    @discardableResult
    public class func save(service: String, key: String, value: String, classType: KCClassType, accessibleType: kCAttrAccessible) throws -> OSStatus {
        let itemData = value.data(using: .utf8)!
        return try save(service: service, key: key, data: itemData, classType: classType, accessibleType: accessibleType)
    }
    
    @discardableResult
    public class func save<T:Codable>(service: String, key: String, value: T, classType: KCClassType, accessibleType: kCAttrAccessible) throws -> OSStatus {
        let itemData = try JSONEncoder().encode(value)
        return try save(service: service, key: key, data: itemData, classType: classType, accessibleType: accessibleType)
    }
    
    public class func save(service: String, key: String, value: String) throws -> OSStatus {
        try save(service: service, key: key, value: value, classType: .genericPassword, accessibleType: .whenUnlocked)
    }
    
    public class func save<T:Codable>(service: String, key: String, value: T) throws -> OSStatus {
        try save(service: service, key: key, value: value, classType: .genericPassword, accessibleType: .whenUnlocked)
    }
    
    @discardableResult
    public class func save(service: String, key: String, data: Data, classType: KCClassType, accessibleType: kCAttrAccessible) throws -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: classType.rawValue,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecValueData as String: data,
            kSecAttrAccessible as String: accessibleType.rawValue
        ]
        // Delete any existing item before adding to avoid conflicts
        SecItemDelete(query as CFDictionary)
        let result: OSStatus = SecItemAdd(query as CFDictionary, nil)
        if result != errSecSuccess {
            throw convertError(result)
        }
        return result
    }
    
    //MARK: - Retrieve
    
    public class func get<T: Codable>(service: String, key: String, classType: KCClassType, accessibleType: kCAttrAccessible) throws -> T? {
        guard let data = try get(service: service, key: key, classType: classType, accessibleType: accessibleType) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    public class func get(service: String, key: String, classType: KCClassType, accessibleType: kCAttrAccessible) throws -> Data? {
        let query: [String: Any] = [
            kSecClass as String: classType.rawValue,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecAttrAccessible as String: accessibleType.rawValue,
            kSecReturnData as String: true,
            kSecReturnAttributes as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if status != errSecSuccess {
            throw convertError(status)
        }
        return (status == errSecSuccess) ? (result as? Data) : nil
    }
    
    //MARK: - Update
    
    @discardableResult
    public class func update(service: String, key: String, value: String, classType: KCClassType, accessibleType: kCAttrAccessible) -> OSStatus {
        update(service: service, key: key, data: value.data(using: .utf8)!, classType: classType, accessibleType: accessibleType)
    }
    
    @discardableResult
    public class func update<T:Codable>(service: String, key: String, value: T, classType: KCClassType, accessibleType: kCAttrAccessible) throws -> OSStatus {
        let itemData = try JSONEncoder().encode(value)
        return update(service: service, key: key, data: itemData, classType: classType, accessibleType: accessibleType)
    }
    
    @discardableResult
    public class func update(service: String, key: String, data: Data, classType: KCClassType, accessibleType: kCAttrAccessible) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: classType.rawValue,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecAttrAccessible as String: accessibleType.rawValue
        ]
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data
        ]
        return SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    }
    
    //MARK: - Delete
    
    @discardableResult
    public class func delete(service: String, key: String , classType: KCClassType, accessibleType: kCAttrAccessible) throws -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: classType.rawValue,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecAttrAccessible as String: accessibleType.rawValue
        ]
        return SecItemDelete(query as CFDictionary)
    }
    
    @discardableResult
    public class func isItemExist(service: String, key: String, classType: KCClassType, accessibleType: kCAttrAccessible) -> Bool {
        // Define the search query
        let query: [String: Any] = [
            kSecClass as String: classType.rawValue,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: false,
            kSecAttrAccessible as String: accessibleType.rawValue
        ]
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        return status == errSecSuccess
    }
}

private extension KCManager {
    
    private class func convertError(_ error: OSStatus) -> KeychainError {
        switch error {
            case errSecItemNotFound:
                return .itemNotFound
            case errSecDataTooLarge:
                return .invalidData
            case errSecDuplicateItem:
                return .duplicateItem
            default:
                return .unexpected(error)
        }
    }
}
