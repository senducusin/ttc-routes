//
//  StopDetailCellViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 4/1/21.
//

import UIKit

struct StopDetailCellViewModel {
    var shapeDestination:String?
    
    var shapeOrigin:String?
    
    var stopTimeCollection :StopTimeCollection

    init(stopTimeCollection:StopTimeCollection){
        self.stopTimeCollection = stopTimeCollection
        let shapes = stopTimeCollection.shape.components(separatedBy: " To ")
        self.shapeOrigin = "Origin: \(shapes[0])"
        self.shapeDestination = "Destination: \(shapes[1])"
    }
    
    var stopTimesCount: Int {
        return stopTimeCollection.stopTimes.count
    }
}

extension StopDetailCellViewModel {
    func timeStopOfIndex(_ index:Int) -> String {
        let stopTime = stopTimeCollection.stopTimes[index].departureTimestamp
        return Date.unixTimestampToDateStr(stopTime, format: .time)
    }
    
    func textColorOfIndex(_ index:Int) -> UIColor {
        
        let interval = stopTimeCollection.stopTimes[index].departureTimestamp - Date().timeIntervalSince1970
        
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
