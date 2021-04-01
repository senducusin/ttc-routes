//
//  StopListCellViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import UIKit

struct StopListCellViewModel {
    var route: Route?
    
    var routeName: String {
        return route?.name ?? ""
    }
    
    var routePropertyIsHidden: Bool {
        return route == nil ? true : false
    }
    
    var noBusIsHidden: Bool {
        return route == nil ? false : true
    }
    
    func departureTimeColor(stop:StopTime) -> UIColor{
        return (stop.departureTimestamp - Date().timeIntervalSince1970) >= 600 ? UIColor.darkGray : UIColor.red
    }
    
    var nextStop: StopTime? {

        guard var stops = route?.stopTimes else {
            return nil
        }
        
        stops = stops.sorted(by:{ $0.departureTimestamp < $1.departureTimestamp})
        
        for stop in stops {
           
            if stop.departureTimestamp >= Date().timeIntervalSince1970 {
                return stop
            }
        }
        
        return nil
    }
    
    var departureTimestampString: String {
        guard let departureTimestamp = nextStop?.departureTimestamp else {
            return "N/A"
        }
    
        
        return Date.unixTimestampToDateStr(departureTimestamp, format: .time)
    }
}
