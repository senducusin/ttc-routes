//
//  Stop.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import Foundation

struct StopResponse: Codable {
    var time: Double
    var stops: [Stop]
    var uri : String
    var name :String
}

struct Stop: Codable {
    var uri: String
    var agency: String
    var name: String
    var routes: [Route]
}

extension StopResponse {
    static func all() -> Resource<StopResponse>?{
        guard let url = URL(string: "https://myttc.ca/finch_station.json") else {
            return nil
        }
        
        return Resource(url: url)
    }
}
