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
    
    func departureTimeColor(stop:StopTime?) -> UIColor{
        guard let stop = stop else {
            return .darkGray
        }
        
        return (stop.departureTimestamp - Date().timeIntervalSince1970) >= 600 ? .darkGray : .red
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
    
    var shapeDestination: String {
        guard let nextStop = nextStop else {
            return "N/A"
        }
        
        let separator = " To "
        
        if !nextStop.shape.contains(separator) {
            return nextStop.shape
        }
        
        let shape = nextStop.shape.components(separatedBy: separator)
        return "To \(shape[1])"
    }
    
    var departureTimestampString: String {
        guard let departureTimestamp = nextStop?.departureTimestamp else {
            return "N/A"
        }
    
        
        return Date.unixTimestampToDateStr(departureTimestamp, format: .time)
    }
}
