//
//  SettingsViewCell.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 4/1/21.
//

import UIKit

class SettingsViewCell: UITableViewCell {
    // MARK: - Properties
    static let cellIdentifier = "SettingsViewCell"
    
    var viewModel: SettingsViewModel? {
        didSet{ self.configure() }
    }

    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setDimensions(height: 28, width: 28)
        imageView.tintColor = .themeMonza
        return imageView
    }()
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.addSubview(self.iconImage)
        self.iconImage.centerX(inView: view)
        self.iconImage.centerY(inView: view)

        view.backgroundColor = .white
        view.setDimensions(height: 40, width: 40)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .themeMonza
        return label
    }()
    
    private lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(switchToggleHandler(sender:)), for: .valueChanged)
        toggle.onTintColor = .themeMonza
        return toggle
    }()
    
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc private func switchToggleHandler(sender:UISwitch){
        guard let viewModel = viewModel else { return }
        
        viewModel.toggleResponse(isOn: sender.isOn)
    }
    
    // MARK: - Helpers
    private func setupUI(){
        self.backgroundColor = .themeCosmos
        
        self.addSubview(self.iconView)
        self.iconView.centerY(inView: self,leftAnchor: self.leftAnchor, paddingLeft: 12)
        
        self.addSubview(self.titleLabel)
        self.titleLabel.centerY(inView: self, leftAnchor: self.iconView.rightAnchor, paddingLeft: 8)
        
        self.contentView.addSubview(self.toggleSwitch)
        self.toggleSwitch.centerY(inView: self)
        self.toggleSwitch.anchor(right: self.rightAnchor, paddingRight: 12)
    }
    
    private func configure(){
        guard let viewModel = viewModel else { return }
        self.iconImage.image = UIImage(systemName: viewModel.iconImageName)
        self.titleLabel.text = viewModel.description
        self.toggleSwitch.isOn = viewModel.switchValue
    }
}
