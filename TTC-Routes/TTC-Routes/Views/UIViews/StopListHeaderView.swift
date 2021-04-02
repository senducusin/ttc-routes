//
//  StopListHeaderView.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 4/2/21.
//

import UIKit

class StopListHeaderView: UIView {
    // MARK: - Properties
    private let noBusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .themeBrinkPink
        label.text = "Error in retrieving the data"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        self.addSubview(self.noBusLabel)
        self.noBusLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 10, paddingRight: 10)
        self.noBusLabel.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
