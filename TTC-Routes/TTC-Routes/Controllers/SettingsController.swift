//
//  SettingsController.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

class SettingsController: UITableViewController {
    // MARK: - Properties
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.navigationBar.barStyle = .white
    }
    
    // MARK: - Helpers
    private func setupUI(){
//        self.tableView.tableHeaderView = self.headerView
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.rowHeight = 64
    }
}
