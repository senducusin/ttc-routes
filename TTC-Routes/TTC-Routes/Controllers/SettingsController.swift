//
//  SettingsController.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

class SettingsController: UIViewController {
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SettingsViewCell.self, forCellReuseIdentifier: SettingsViewCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorColor = .themeMonza
        tableView.separatorInset = .zero
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let settingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gear")
        imageView.backgroundColor = .white
        imageView.tintColor = .themeMonza
        return imageView
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(exitDidTap), for: .touchUpInside)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 22, width: 22)
        return button
    }()
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 1.5))
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .themeMonza
        return view
    }()
    
    let tableViewContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Created by Jansen Ducusin"
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    private let versionLabel: UILabel = {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Version \(appVersion ?? "N/A")"
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.headerView)
        self.headerView.anchor(
            top: self.view.topAnchor,
            left: self.view.leftAnchor,
            right: self.view.rightAnchor,
            width: self.view.frame.width
        )
        self.headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.35).isActive = true
//
        self.view.addSubview(self.tableViewContainer)
        self.tableViewContainer.anchor(
            top: self.headerView.bottomAnchor,
            left: self.view.leftAnchor,
            bottom: self.view.bottomAnchor,
            right: self.view.rightAnchor,
            width: self.view.frame.width
        )
        
        self.tableViewContainer.addSubview(self.tableView)
        self.tableView.anchor(
            top: self.tableViewContainer.topAnchor,
            left: self.tableViewContainer.leftAnchor,
            right: self.tableViewContainer.rightAnchor)
        
        self.setupFooterView()
    }
    
    override func viewDidLayoutSubviews() {
        self.setupDismissButton()
        self.setupSettingsImage()
        self.setupSettingsLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Selectors
    @objc func exitDidTap(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func setupFooterView(){
        
        self.view.addSubview(self.authorLabel)
        self.authorLabel.anchor(left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingBottom: 10)
        
        self.view.addSubview(self.versionLabel)
        self.versionLabel.anchor(top:self.tableView.bottomAnchor ,left: self.view.leftAnchor, bottom: self.authorLabel.topAnchor, right: self.view.rightAnchor)
    }
    
    private func setupSettingsLabel(){
        self.headerView.addSubview(self.settingsLabel)
        self.settingsLabel.centerX(inView: self.headerView)
        self.settingsLabel.anchor(top:self.settingsImage.bottomAnchor, paddingTop:4)
    }
    
    private func setupDismissButton(){
        self.headerView.addSubview(self.dismissButton)
        self.dismissButton.anchor(top: self.headerView.topAnchor, left: self.headerView.leftAnchor, paddingTop: 24, paddingLeft: 12)
        self.dismissButton.setDimensions(height: 48, width: 48)
    }
    
    private func setupSettingsImage(){
        self.headerView.addSubview(self.settingsImage)
        
        self.settingsImage.heightAnchor.constraint(equalTo: self.headerView.heightAnchor, multiplier: 0.3722).isActive = true
        self.settingsImage.widthAnchor.constraint(equalTo: self.headerView.heightAnchor, multiplier: 0.3970).isActive = true
        
        self.settingsImage.centerX(inView: self.headerView)
        self.settingsImage.centerY(inView: self.headerView)
        
        let avgHeightWidth = (settingsImage.frame.height + settingsImage.frame.width)/2
        self.settingsImage.layer.cornerRadius = avgHeightWidth/2
    }
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsViewModel.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewCell.cellIdentifier, for: indexPath) as! SettingsViewCell
        
        cell.viewModel = SettingsViewModel(rawValue: indexPath.row)
        
        return cell
    }
}
