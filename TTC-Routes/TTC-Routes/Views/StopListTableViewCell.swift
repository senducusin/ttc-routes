//
//  StopListTableViewCell.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import UIKit

class StopListTableViewCell: UITableViewCell {
    // MARK: - Properties
    var route:Route? {
        didSet{
            self.configure()
        }
    }
    
    static let cellIdentifier = "StopListTableViewCell"
    
    private var routeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configure(){
        if let route = self.route {
            self.routeNameLabel.text = route.name
        }else{
            self.routeNameLabel.text = "No Bus Available"
        }
    }
    
    private func setupUI(){
        self.addSubview(routeNameLabel)
        self.routeNameLabel.centerY(inView: self,leftAnchor: self.leftAnchor, paddingLeft: 17)
    }
}
