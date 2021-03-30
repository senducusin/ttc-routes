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
        return route?.name ?? "No Bus Available"
    }
    
    var routeNameFont: UIFont {
        return route == nil ? UIFont.italicSystemFont(ofSize: 14) : UIFont.systemFont(ofSize: 14)
    }
    
    var routeFontColor: UIColor{
        return route == nil ? UIColor.lightGray : UIColor.black
    }
}
