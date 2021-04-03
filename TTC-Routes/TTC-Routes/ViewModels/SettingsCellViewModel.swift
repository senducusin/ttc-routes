//
//  SettingsCellViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import Foundation

enum SettingsCellViewModel: Int, CaseIterable{
    case showAll
    case use24hFormat
    
    var description: String{
        switch self {
        case .showAll: return "Show All Stops"
        case .use24hFormat: return "24 Hours Time Format"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .showAll: return "signpost.right"
        case .use24hFormat: return "timer"
        }
    }
    
    var userDefaultKeys: String {
        switch self {
        case .showAll: return USERDEFAULT_KEY_SHOW_ALL_STOPS
        case .use24hFormat: return USERDEFAULT_KEY_USE_24H_TIME_FORMAT
        }
    }
    
    func toggleResponse(isOn: Bool){
        let defaults = UserDefaults.standard
        
        defaults.setValue(isOn, forKey: self.userDefaultKeys)
    }
    
    var switchValue: Bool {
        let defaults = UserDefaults.standard
        
        return defaults.bool(forKey: self.userDefaultKeys)
    }
}
