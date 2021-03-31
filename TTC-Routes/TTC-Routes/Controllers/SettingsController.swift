//
//  SettingsController.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

class SettingsController: UITableViewController {
    // MARK: - Properties
    private lazy var headerView = SettingsHeader(frame:
                                                    .init(x: 0, y: 0, width: self.view.frame.width, height: 380))
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        headerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.navigationBar.barStyle = .white
    }
    
    // MARK: - Helpers
    private func setupTableView(){
        self.tableView.tableHeaderView = self.headerView
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.rowHeight = 64
    }
}

extension SettingsController: SettingsHeaderDelegate {
    func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
}
