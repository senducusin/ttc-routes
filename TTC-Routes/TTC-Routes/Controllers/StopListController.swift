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
    var tableRefreshControl = UIRefreshControl()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRefreshController()
        
        self.setupTableView()
        
        self.fetchStops()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsDidTap))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update indicators for changes
        self.tableView.reloadData()
    }
    
    // MARK: - Selectors
    @objc private func fetchStops(){
        self.tableRefreshControl.beginRefreshing()
        
        if let resource = StopResponse.all() {
            WebService().load(resource: resource) { [weak self] result in
                
                switch result {
                case .success(let stopResponse):
                    self?.viewModel = StopListViewModel(stopResponse)
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.navigationItem.setTitle(stopResponse.name, subtitle: Date.unixTimestampToDateStr(stopResponse.time, format: .date))
                        self?.tableRefreshControl.endRefreshing()
                    }
                    
                    self?.updateTableRefreshControl()
                   
                    
                case .failure(let error):
                print(error.localizedDescription)
                    
                }
            }
        }
    }
    
    @objc func settingsDidTap(){
        let controller = SettingsController(style: .insetGrouped)
        let nav = UINavigationController(rootViewController: controller)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true,completion: nil)
    }
    
    // MARK: - Helpers
    private func setupRefreshController(){
        self.tableRefreshControl.attributedTitle = NSAttributedString(string: "Fetching Stops and Routes")
        self.tableRefreshControl.addTarget(self, action: #selector(fetchStops), for: .valueChanged)
    }
    
    private func setupTableView(){
        self.tableView.addSubview(self.tableRefreshControl)
        self.tableView.register(StopListTableViewCell.self, forCellReuseIdentifier: StopListTableViewCell.cellIdentifier)
        self.tableView.rowHeight = 110
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
    }
    
    private func updateTableRefreshControl(){
        if var viewModel = viewModel {
            if !viewModel.appStarted {
                viewModel.appStarted.toggle()
                
                // Adds smoothness to animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                    self.tableRefreshControl.attributedTitle = viewModel.refreshControlText
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
        guard let viewModel = viewModel else {return 1}
        
        return viewModel.numberOfRowsInSection(section)
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
        
        let controller = StopDetailView(route: route, stop: stop)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .themeMonza
        }
    }
}
