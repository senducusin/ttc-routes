//
//  RouteListController.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import UIKit

class RouteListController: UITableViewController {
    // MARK: - Properties
    var route: Route?
    
    // MARK: - Lifecycle
    init(route: Route){
        self.route = route
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let route = self.route {
            self.title = route.name
        }
    }
}
