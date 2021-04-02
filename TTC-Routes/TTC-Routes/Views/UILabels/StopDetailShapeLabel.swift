//
//  StopDetailShapeLabel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 4/1/21.
//

import UIKit

class StopDetailShapeLabel: UILabel {
    init(){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 0.25))
        adjustsFontSizeToFitWidth = true
        textColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
