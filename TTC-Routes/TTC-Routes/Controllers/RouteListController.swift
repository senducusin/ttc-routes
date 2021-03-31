//
//  RouteListController.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import UIKit

class RouteListController: UITableViewController {
    // MARK: - Properties
    var route: Route
    var stopName: String
    var agency: String
    
    private lazy var headerView = RouteListHeaderView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 240))
    
    
    // MARK: - Lifecycle
    init(route: Route, stopName:String, agency:String){
        self.route = route
        self.stopName = stopName
        self.agency = agency
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = route.name
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView()
    }
}
