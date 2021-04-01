//
//  StopDetailTableViewCell.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/31/21.
//

import UIKit

class StopDetailTableViewCell: UITableViewCell {
    // MARK: - Properties
    var stopTimeCollection:StopTimeCollection? {
        didSet{
            self.configure()
        }
    }
    
    private let subParentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let stopShapeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let stackViewTimeStopsContainer: UIStackView = {
        let stack  = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }()
    
    private let clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let pathImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "point.topleft.down.curvedto.point.bottomright.up")
        imageView.tintColor = .white
        return imageView
    }()
    
    static let cellIdentifier = "StopDetailTableViewCell"
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupUI(){
        self.addSubview(self.subParentView)
        let padding:CGFloat = 10
        self.subParentView.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            paddingLeft: padding,
            paddingBottom: padding,
            paddingRight: padding
        )
        
        let topHorizontalView = UIView()
        self.subParentView.addSubview(topHorizontalView)
        topHorizontalView.anchor(top: subParentView.topAnchor, left: subParentView.leftAnchor, right: subParentView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: self.frame.height/2)
        
        topHorizontalView.addSubview(self.pathImageView)
        self.pathImageView.centerY(inView: topHorizontalView, leftAnchor: topHorizontalView.leftAnchor)
        
        topHorizontalView.addSubview(self.stopShapeLabel)
        self.stopShapeLabel.centerY(inView: topHorizontalView, leftAnchor: self.pathImageView.rightAnchor,paddingLeft: 5)
        
        let bottomHorizontalView = UIView()
        self.subParentView.addSubview(bottomHorizontalView)
        bottomHorizontalView.anchor(top: topHorizontalView.bottomAnchor, left: subParentView.leftAnchor, bottom: subParentView.bottomAnchor, right: subParentView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, height: self.frame.height/2)
        
        bottomHorizontalView.addSubview(self.clockImageView)
        self.clockImageView.centerY(inView: bottomHorizontalView, leftAnchor: bottomHorizontalView.leftAnchor)
        
        bottomHorizontalView.addSubview(self.stackViewTimeStopsContainer)
        self.stackViewTimeStopsContainer.anchor(top: bottomHorizontalView.topAnchor, left: self.clockImageView.rightAnchor, bottom: bottomHorizontalView.bottomAnchor, right: bottomHorizontalView.rightAnchor, paddingLeft: 2)
    }
    
    private func configure(){
        self.stopShapeLabel.text = stopTimeCollection?.shape
        
        if let stopTimes = self.stopTimeCollection?.stopTimes {
            for stopTime in stopTimes {
                self.showStopTime(stopTime)
            }
            
            let spacer = UIView()
            self.stackViewTimeStopsContainer.addArrangedSubview(spacer)
        }
    }
    
    private func showStopTime(_ stopTime: StopTime){
        
        let viewModel = StopTimeViewModel(stopTime: stopTime)
        
        let timeLabelContainer = UIView()

        timeLabelContainer.setDimensions(height: 20, width: 70)

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = viewModel.timeString
        label.textColor = viewModel.textColor
        timeLabelContainer.addSubview(label)
        label.centerX(inView: timeLabelContainer)
        label.centerY(inView: timeLabelContainer)

        self.stackViewTimeStopsContainer.addArrangedSubview(timeLabelContainer)
    }
}
