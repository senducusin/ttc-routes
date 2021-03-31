//
//  RouteListHeaderView.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

class RouteListHeaderView: UIView {
    // MARK: - Properties
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ttc-logo")
        return imageView
    }()
    
    let agencyLabel: HeaderLabel = {
        return HeaderLabel()
    }()
    
    let stopNameLabel: HeaderLabel = {
        return HeaderLabel()
    }()
    
    let routeGroupIdLabel: HeaderLabel = {
        return HeaderLabel()
    }()

    // MARK: - Lifecycle
    override init(frame:CGRect){
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.setupUI()
    }
    
    // MARK: - Helpers
    private func setupUI(){
        
        self.setupLogoImage()
        
        self.agencyLabel.text = "Agency: Toronto Transit Commission"
        self.stopNameLabel.text = "Stop: Finch Station Bus Bay"
        self.routeGroupIdLabel.text = "Route Group ID: 20"
        
        let stack = UIStackView(arrangedSubviews: [self.agencyLabel, self.stopNameLabel, self.routeGroupIdLabel])
        self.addSubview(stack)
        stack.anchor(top:self.logoImageView.bottomAnchor, left: self.leftAnchor, paddingTop: 20, paddingLeft: 17)
        
        stack.axis = .vertical
        stack.spacing = 12
    }
    
    private func setupLogoImage(){
        self.logoImageView.setDimensions(height: 100, width: 240)
        self.addSubview(self.logoImageView)
        self.logoImageView.centerX(inView: self)
        self.logoImageView.anchor(top:self.topAnchor, paddingTop: 35)
    }
}
