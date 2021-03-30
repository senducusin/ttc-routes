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
    case dateTime = "MMMM dd y, hh:mm a"
}

extension Date {
    static func unixTimestampToDateStr(_ timeStamp:Double, format:DateFormat) -> String{
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC-4")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }
}
