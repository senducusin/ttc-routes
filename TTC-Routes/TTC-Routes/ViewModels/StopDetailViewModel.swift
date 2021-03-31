//
//  StopDetailViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import Foundation

struct StopDetailViewModel {
    
    var stopTimeCollection = [StopTimeCollection]()
    
    var route: Route
    
    var stop: Stop
    
    var uniqueStopTimesCount: Int {
        return self.stopTimeCollection.count
    }
}

extension StopDetailViewModel {
    init(route: Route, stop:Stop){
        self.stop = stop
        self.route = route
        
        self.getStopTimeCollection()
    }
}

extension StopDetailViewModel {
    mutating func getStopTimeCollection(){
        
        var uniqueShapes = [String]()
        
        // Display unique Shapes to Detail View
        for stopTime in route.stopTimes {
            let shape = stopTime.shape
            if !uniqueShapes.contains(shape) {
                uniqueShapes.append(shape)
            }
        }
        
        // Collect the stoptimes and display on each shape uniquely
        for uniqueShape in uniqueShapes {
            var _uniqueStopTime = [StopTime]()
            
            for stopTime in route.stopTimes {
                if stopTime.shape == uniqueShape {
                    _uniqueStopTime.append(stopTime)
                }
            }
            
            stopTimeCollection.append(StopTimeCollection(shape: uniqueShape, stopTimes: _uniqueStopTime))
        }
    }
}
