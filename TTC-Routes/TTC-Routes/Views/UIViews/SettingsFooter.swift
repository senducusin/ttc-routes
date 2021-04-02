//
//  SettingsFooter.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 4/1/21.
//

import UIKit

class SettingsFooter:UIView {
    // MARK: - Properties
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
    
    // MARK: - Lifecycles
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupUI(){
        self.addSubview(self.authorLabel)
        self.authorLabel.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingBottom: 10)
        
        self.addSubview(self.versionLabel)
        self.versionLabel.anchor(left: self.leftAnchor, bottom: self.authorLabel.topAnchor, right: self.rightAnchor, paddingBottom: 10)
    }
}
