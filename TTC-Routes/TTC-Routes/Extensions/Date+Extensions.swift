//
//  Date+Extensions.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import Foundation

enum DateFormat: String {
    case date = "MMM dd y"
    case time = "hh:mm a"
    case dateTimeAm = "MMMM dd y, hh:mm a"
}

extension Date {
    static func unixTimestampToDateStr(_ timeStamp:Double, format:DateFormat) -> String{
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC-4")
        dateFormatter.locale = NSLocale.current
        
        let user24Time = UserDefaults.standard.bool(forKey: USERDEFAULT_KEY_USE_24H_TIME_FORMAT)
        
        dateFormatter.dateFormat = user24Time ?
            format.rawValue
            .replacingOccurrences(of: "hh", with: "HH")
            .replacingOccurrences(of: " a", with: "") :
            format.rawValue
        
        return dateFormatter.string(from: date)
    }
}
