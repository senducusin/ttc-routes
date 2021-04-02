//
//  StopListViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import Foundation

struct StopListViewModel{
    var appStarted = false
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
        return UserDefaults.standard.bool(forKey: USERDEFAULT_KEY_SHOW_ALL_STOPS)
    }
    
    var numberOfSections: Int {
        return showAll ? stops.count : filteredStops.count
    }
    
    var refreshControlText: NSAttributedString {
        return appStarted ? NSAttributedString(string: "Pull to refresh") : NSAttributedString(string: "Fetching Stops and Routes")
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
        
        // allCount's minimum value is set to 1, to show "No available bus" cell in the tableView
        let allCount = stops[index].routes.count == 0 ? 1 : stops[index].routes.count
        
        return showAll ? allCount : filteredStops[index].routes.count
    }
    
    func stopAtIndexPath(_ indexPath:IndexPath) -> Stop {
        
        return showAll ? stops[indexPath.section] : filteredStops[indexPath.section]
    }
    
    func routeAtIndexPath(_ indexPath:IndexPath) -> Route? {
        let routes = showAll ? stops[indexPath.section].routes : filteredStops[indexPath.section].routes
        
        return routes.indices.contains(indexPath.row) ? routes[indexPath.row] : nil
    }
}
