//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 08/04/26.
//

import Foundation


@propertyWrapper
struct KCWrapper<T: Codable>{
    let key: String
    let service: String
    let classType: KCClassType
    let accessibleType: kCAttrAccessible
    
    private var currentValue: T?
    
    public var wrappedValue: T? {
        get {
            return getItem()
        }
        
        set {
            if let newValue {
                getItem() != nil
                ? updateItem(newValue)
                : saveItem(newValue)
            } else {
                deleteItem()
            }
        }
    }
    
    public init(key: String, classType: KCClassType, accessibleType: kCAttrAccessible, service: String) {
        self.key = key
        self.classType = classType
        self.service = service
        self.accessibleType = accessibleType
    }
}

// MARK: - Helpers
private extension KCWrapper {
    
    func getItem() -> T? {
        do {
            return try KCManager.get(service: service, key: key, classType: classType, accessibleType: accessibleType)
        } catch {
            handleError(error)
        }
        return nil
    }
    
    func saveItem(_ item: T) {
        do {
            try KCManager.save(service: service, key: key, value: item, classType: classType, accessibleType: accessibleType)
        } catch {
            handleError(error)
        }
    }
    
    func updateItem(_ item: T) {
        do {
            try KCManager.update(service: service, key: key, value: item, classType: classType, accessibleType: accessibleType)
        } catch {
            handleError(error)
        }
    }
    
    func deleteItem() {
        do {
            try KCManager.delete(service: service, key: key, classType: classType, accessibleType: accessibleType)
        } catch {
            handleError(error)
        }
    }
    
    func handleError(_ error: Error) {
        LoggerUtils.log(error.localizedDescription, type: .error)
    }
}
