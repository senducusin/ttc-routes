//
//  StopDetailTimeLabel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 4/1/21.
//

import UIKit

class StopDetailTimeLabel: UILabel {
    init(){
        super.init(frame: .zero)
        font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
