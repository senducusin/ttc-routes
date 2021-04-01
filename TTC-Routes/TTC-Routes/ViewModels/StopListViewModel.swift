//
//  StopListViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import Foundation

struct StopListViewModel{
    
    var time: Double
    var stops: [Stop]
    var name: String
}

extension StopListViewModel {
    init(_ stopResponse: StopResponse){
        self.time = stopResponse.time
        self.stops = stopResponse.stops
        self.name = stopResponse.name
    }
}

extension StopListViewModel {
    
    var filteredStops: [Stop] {
        return stops.filter {$0.routes.count > 0}
    }
    
    var showAll: Bool {
        return UserDefaults.standard.bool(forKey: USERDEFAULT_KEY_SHOW_ALL_SCHEDULES)
    }
    
    var numberOfSections: Int {
        return showAll ? stops.count : filteredStops.count
    }
    
    func sectionTitle(_ index:Int) -> String {
        let stopName = showAll ? stops[index].name : filteredStops[index].name
        
        if stopName.hasPrefix(self.name) {
            let newName = stopName.replacingOccurrences(of: "\(name) ", with: "")
            return newName
        }
        
        return stopName
    }
    
    func numberOfRowsInSection(_ index:Int) -> Int {
        return showAll ? stops[index].routes.count : filteredStops[index].routes.count
    }
    
    func stopAtIndexPath(_ indexPath:IndexPath) -> Stop {
        
        return showAll ? stops[indexPath.section] : filteredStops[indexPath.section]
    }
    
    func routeAtIndexPath(_ indexPath:IndexPath) -> Route? {
        let routes = showAll ? stops[indexPath.section].routes : filteredStops[indexPath.section].routes
        
        return routes.indices.contains(indexPath.row) ? routes[indexPath.row] : nil
    }
}
