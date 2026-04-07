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
}
