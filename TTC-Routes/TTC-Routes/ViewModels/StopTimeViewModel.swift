//
//  StopTimeViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

struct StopTimeViewModel {
    var stopTime: StopTime
    
    var timeString: String {
        return Date.unixTimestampToDateStr(stopTime.departureTimestamp, format: .time)
    }
    
    var textColor: UIColor {
        
        let interval = stopTime.departureTimestamp - Date().timeIntervalSince1970
        
        switch interval {
        
        case let interval where interval < 0:
            return .lightGray
        
        case 0...600:
            return .red
        
        case 600...1200:
            return .systemPink
        
        default:
            return .black
        }
    }
}
