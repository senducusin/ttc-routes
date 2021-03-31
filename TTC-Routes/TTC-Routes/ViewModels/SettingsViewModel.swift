//
//  SettingsViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import Foundation

enum SettingsViewModel: Int, CaseIterable{
    case hideEmptySchedules
    case use24HourFormat
    
    var description: String{
        switch self {
        case .hideEmptySchedules: return "Hide Empty Schedules"
        case .use24HourFormat: return "24 Hours Time Format"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .hideEmptySchedules: return "eye.slash"
        case .use24HourFormat: return "timer"
        }
    }
}
