//
//  StopListController.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import UIKit

class StopListController: UITableViewController {
    
    // MARK: - Properties
    var viewModel: StopListViewModel?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.fetchStops()
    }
    
    // MARK: - Helpers
    private func setupTableView(){
        self.tableView.register(StopListTableViewCell.self, forCellReuseIdentifier: StopListTableViewCell.cellIdentifier)
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView()
    }
    
    private func fetchStops(){
        if let resource = StopResponse.all() {
            WebService().load(resource: resource) { result in
                switch result {
                case .success(let stopResponse):
                    self.viewModel = StopListViewModel(stopResponse)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.navigationItem.setTitle(stopResponse.name, subtitle: Date.unixTimestampToDateStr(stopResponse.time, format: .date))
                    }
                
                case .failure(let error):
                print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: Tableview Datasource & Protocols
extension StopListController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let viewModel = self.viewModel {
            return viewModel.sectionTitle(section)
        }
        
        return "Invalid Stop"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 1
        }
        
        let rowCount = viewModel.numberOfRowsInSection(section)
        
        return rowCount == 0 ? 1 : rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StopListTableViewCell.cellIdentifier, for: indexPath) as! StopListTableViewCell
        
        cell.route = self.viewModel?.routeAtIndexPath(indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let route = self.viewModel?.routeAtIndexPath(indexPath),
              let stop = self.viewModel?.stopAtIndexPath(indexPath) else {
            return
        }
        
        self.navigateToDetailViewWithRoute(route, stop: stop)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func navigateToDetailViewWithRoute(_ route:Route, stop:Stop) {
        
        let controller = RouteListController(route: route, stopName: stop.name, agency: stop.agency)
        navigationController?.pushViewController(controller, animated: true)
    }
}
