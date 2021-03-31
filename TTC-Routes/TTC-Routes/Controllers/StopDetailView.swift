//
//  StopDetailView.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import UIKit

class StopDetailView: UITableViewController {
    // MARK: - Properties
    
    var viewModel: StopDetailViewModel
    
    private lazy var headerView = StopDetailHeaderView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 225), viewModel: viewModel)
    
    
    // MARK: - Lifecycle
    init(route: Route, stop:Stop){
        self.viewModel = StopDetailViewModel(route: route, stop: stop)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.route.name
        self.setupTableView()
    }
    
    // MARK: - Helpers
    private func setupTableView(){
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.register(StopDetailTableViewCell.self, forCellReuseIdentifier: StopDetailTableViewCell.cellIdentifier)
        self.tableView.rowHeight = 80
    }
}

// MARK: Tableview Datasource & Protocols
extension StopDetailView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.uniqueStopTimesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StopDetailTableViewCell.cellIdentifier, for: indexPath) as! StopDetailTableViewCell
        
        cell.stopTimeCollection = viewModel.stopTimeCollection[indexPath.row]
        
        return cell
    }
}
