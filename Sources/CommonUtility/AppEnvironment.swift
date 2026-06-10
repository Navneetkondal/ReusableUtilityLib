//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 07/04/26.
//

import Foundation

public struct AppEnvironment{
    public static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    public static var isSimulator: Bool{
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    public static var isDevice: Bool{
        return !isSimulator
    }
    
    public var isMacCatalyst: Bool{
        #if targetEnvironment(macCatalyst)
        return true
        #else
        return false
        #endif
    }
    
    public var isIOS: Bool{
        #if os(iOS)
        return true
        #else
        return false
        #endif
    }
    
    public var istvOS: Bool{
        #if os(tvOS)
        return true
        #else
        return false
        #endif
    }
    
    public var ismacOS: Bool{
        #if os(macOS)
        return true
        #else
        return false
        #endif
    }
    
    public var isVisionOS: Bool{
        #if os(visionOS)
        return true
        #else
        return false
        #endif
    }
}
