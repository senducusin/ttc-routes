//
//  RegularLabel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

class RegularLabel: UILabel {
    init(){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 14)
        textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
