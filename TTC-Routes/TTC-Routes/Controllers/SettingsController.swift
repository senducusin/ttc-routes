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
        self.tableView.register(SettingsViewCell.self, forCellReuseIdentifier: SettingsViewCell.cellIdentifier)
        self.tableView.separatorStyle = .singleLine
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.rowHeight = 64
        self.tableView.allowsSelection = false
        self.tableView.isUserInteractionEnabled = true
    }
}

extension SettingsController {
    // Allows space between header and tableView
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewCell.cellIdentifier, for: indexPath) as! SettingsViewCell
        
        cell.viewModel = SettingsViewModel(rawValue: indexPath.row)
        
        return cell
    }
}

extension SettingsController: SettingsHeaderDelegate {
    func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
}
