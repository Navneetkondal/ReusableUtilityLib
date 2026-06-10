//
//  extension + Date.swift
//  SwiftUIReusable
//
//  Created by Navneet on 31/03/26.
//

import Foundation

public extension Date{
    
    static func getDateFormatter(_ format: String, identifire: String? = nil, timeZone :TimeZone? = nil) -> DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone ?? TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: identifire ?? "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter
    }
    
    static func getDateStringFromDate(_ rawDate: Date, format:String, timeZone :TimeZone? = nil) -> String {
        return getDateFormatter(format, timeZone: timeZone).string(from: rawDate)
    }
    
    static func getDateFromString(_ dateString: String, format:String, timeZone: TimeZone? = nil) -> Date? {
        return getDateFormatter(format, timeZone: timeZone).date(from: dateString)
    }
    
    static func getDateFromDate(_ rawDate: Date, format:String, timeZone :TimeZone? = nil) -> Date?{
        let dateStr = Date.getDateStringFromDate(rawDate, format: format, timeZone: timeZone)
        return Date.getDateFromString(dateStr, format: format, timeZone: timeZone)
    }
}
