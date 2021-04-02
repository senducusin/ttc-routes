//
//  SettingsHeader.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

protocol SettingsHeaderDelegate: class {
    func dismissController()
}

class SettingsHeader: UIView {
    // MARK: - Properties
    weak var delegate: SettingsHeaderDelegate?
    
    private let settingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gear")
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 77.5
        imageView.tintColor = .themeMonza
        return imageView
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(exitDidTap), for: .touchUpInside)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 22, width: 22)
        return button
    }()
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 1.5))
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func exitDidTap(){
        self.delegate?.dismissController()
    }
    
    // MARK: - Helper
    private func setupUI(){
        self.backgroundColor = .themeMonza
        
        addSubview(self.dismissButton)
        self.dismissButton.anchor(top:topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12)
        self.dismissButton.setDimensions(height: 48, width: 48)
        
        addSubview(self.settingsImage)
        self.settingsImage.setDimensions(height: 150, width: 160)
        self.settingsImage.centerX(inView: self)
        self.settingsImage.centerY(inView: self)

        addSubview(self.settingsLabel)
        self.settingsLabel.centerX(inView: self)
        self.settingsLabel.anchor(top:self.settingsImage.bottomAnchor, paddingTop: 7)
    }
}
