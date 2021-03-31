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
    
    let agencyLabel: RegularLabel = {
        return RegularLabel()
    }()
    
    let stopNameLabel: RegularLabel = {
        return RegularLabel()
    }()
    
    let routeGroupIdLabel: RegularLabel = {
        return RegularLabel()
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
        self.logoImageView.setDimensions(height: 50, width: 100)
        self.addSubview(self.logoImageView)
        self.logoImageView.centerX(inView: self)
        self.logoImageView.anchor(top:self.topAnchor, paddingTop: 10)
    }
}
