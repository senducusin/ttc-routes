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
        
        self.tableView.register(StopListTableViewCell.self, forCellReuseIdentifier: StopListTableViewCell.cellIdentifier)
        
        if let resource = StopResponse.all() {
            WebService().load(resource: resource) { result in
                switch result {
                case .success(let stopResponse):
                    self.viewModel = StopListViewModel(stopResponse)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
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
}
