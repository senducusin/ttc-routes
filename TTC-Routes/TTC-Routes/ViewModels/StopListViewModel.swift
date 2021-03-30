//
//  StopListViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import Foundation

struct StopListViewModel{
    var time: Int
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
    var numberOfSections: Int {
        return stops.count
    }
    
    func sectionTitle(_ index:Int) -> String {
        return stops[index].name
    }
    
    func numberOfRowsInSection(_ index:Int) -> Int {
        return stops[index].routes.count
    }
    
    func routeAtIndexPath(_ indexPath:IndexPath) -> Route? {
        let routes = stops[indexPath.section].routes
        
        return routes.indices.contains(indexPath.row) ? routes[indexPath.row] : nil
    }
}
