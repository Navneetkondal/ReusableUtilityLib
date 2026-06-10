


import Foundation

/// @UserDefaultWrapper(wrappedValue: "", key: "name")
/// private var name: String?
@propertyWrapper public struct UserDefaultWrapper<Value>{
    public var wrappedValue: Value {
        get {
            return storage.value(forKey: key) as? Value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
        }
    }
    
    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults
    
    public init(wrappedValue defaultValue: Value,
                key: String,
                storage: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
    
    public init<T: RawRepresentable>(wrappedValue defaultValue: Value,
                                     key: T,
                                     storage: UserDefaults = .standard) where T.RawValue == String{
        self.defaultValue = defaultValue
        self.key = key.rawValue
        self.storage = storage
    }
}

protocol ModelObjToDictProtocol {
    func toDict() -> [String:Any]
}

extension ModelObjToDictProtocol {
    
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            /** set variable name as key */
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}



