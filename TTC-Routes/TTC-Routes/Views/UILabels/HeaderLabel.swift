//
//  HeaderLabel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

class HeaderLabel: UILabel {
    init(){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 16)
        textColor = .black
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
