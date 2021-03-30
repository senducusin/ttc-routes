//
//  Route.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import Foundation

struct Route: Codable {
    var uri: String
    var stopTimes: [StopTime]
    var routeGroupId: String
    var name: String
}

struct StopTime:Codable {
    var serviceId: Int
    var shape: String
    var departureTime: String
    var departureTimestamp: Double
}
