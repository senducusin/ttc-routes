//
//  StopDetailHeaderView.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

class StopDetailHeaderView: UIView {
    // MARK: - Properties
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ttc-logo")
        return imageView
    }()
    
    let agencyLabel: HeaderLabel = {
        let label = HeaderLabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let stopNameLabel: HeaderLabel = {
        return HeaderLabel()
    }()
    
    let routeGroupIdLabel: HeaderLabel = {
        return HeaderLabel()
    }()
    
    // MARK: - Lifecycle
    init(frame:CGRect, viewModel: StopDetailViewModel){
        super.init(frame: frame)
        
        self.agencyLabel.text = (viewModel.stop.agency)
        self.stopNameLabel.text = (viewModel.stop.name)
        self.routeGroupIdLabel.text = "Route Group ID: \(viewModel.route.routeGroupId)"
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
        
        let stack = UIStackView(arrangedSubviews: [
                                    self.agencyLabel,
                                    self.stopNameLabel,
                                    self.routeGroupIdLabel
        ])
        
        self.addSubview(stack)
        stack.anchor(top:self.logoImageView.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 17)
        
        stack.axis = .vertical
        stack.spacing = 6
    }
    
    private func setupLogoImage(){
        self.logoImageView.setDimensions(height: 100, width: 240)
        self.addSubview(self.logoImageView)
        self.logoImageView.centerX(inView: self)
        self.logoImageView.anchor(top:self.topAnchor, paddingTop: 17)
    }
}
