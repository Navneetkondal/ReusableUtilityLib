//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 07/04/26.
//

import Foundation

public final class Logger: NSObject{
    
    private override init() { }
    
    public class func log(_ message: String, type: LogType,  file: String = #file, function: String = #function, line: UInt = #line) {
        if AppEnvironment.isDebug{
            print("\(type): \(message) - File: \(file), Function: \(function), Line: \(line)")
        }
    }
    
    public class func logError(_ message: String,  file: String = #file, function: String = #function, line: UInt = #line){
        log(message, type: .error, file: file, function: function, line: line)
    }
    
    public class func logInfo(_ message: String,  file: String = #file, function: String = #function, line: UInt = #line){
        log(message, type: .info, file: file, function: function, line: line)
    }
    
    public class func logWarning(_ message: String,  file: String = #file, function: String = #function, line: UInt = #line){
        log(message, type: .warning, file: file, function: function, line: line)
    }
    
    public enum LogType{
        case error
        case warning
        case info
    }
}
