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
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(exitDidTap), for: .touchUpInside)
        button.tintColor = .black
        button.imageView?.setDimensions(height: 22, width: 22)
        return button
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
        addSubview(self.dismissButton)
        self.dismissButton.anchor(top:topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12)
        self.dismissButton.setDimensions(height: 48, width: 48)
    }
}
