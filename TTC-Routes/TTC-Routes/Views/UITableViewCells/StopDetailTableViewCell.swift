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
    
    var viewModel: StopDetailCellViewModel?
    
    private let subParentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let originShapeLabel: StopDetailShapeLabel = {
        return StopDetailShapeLabel()
     }()
    
    private let destinationShapeLabel: StopDetailShapeLabel = {
       return StopDetailShapeLabel()
    }()
    
    private let stopTimeALabel: StopDetailTimeLabel = {
        return StopDetailTimeLabel()
    }()
    
    private let stopTimeBLabel: StopDetailTimeLabel = {
        return StopDetailTimeLabel()
    }()
    
    private let stopTimeCLabel: StopDetailTimeLabel = {
        return StopDetailTimeLabel()
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
        topHorizontalView.anchor(top: subParentView.topAnchor, left: subParentView.leftAnchor, right: subParentView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 44)
        
        topHorizontalView.addSubview(self.pathImageView)
        self.pathImageView.centerY(inView: topHorizontalView, leftAnchor: topHorizontalView.leftAnchor)
        self.pathImageView.setDimensions(height: 24, width: 20)
        
        let stackShapes = UIStackView(arrangedSubviews: [self.originShapeLabel, self.destinationShapeLabel])
        stackShapes.axis = .vertical
        
        topHorizontalView.addSubview(stackShapes)
        stackShapes.anchor(
            top: topHorizontalView.topAnchor,
            left: self.pathImageView.rightAnchor,
            bottom: topHorizontalView.bottomAnchor,
            right: topHorizontalView.rightAnchor, paddingLeft: 5, paddingBottom: 5)
        
        let bottomHorizontalView = UIView()
        self.subParentView.addSubview(bottomHorizontalView)
        bottomHorizontalView.anchor(top: topHorizontalView.bottomAnchor, left: subParentView.leftAnchor, bottom: subParentView.bottomAnchor, right: subParentView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, height: self.frame.height/2)
        
        bottomHorizontalView.addSubview(self.clockImageView)
        self.clockImageView.setDimensions(height: 20, width: 20)
        self.clockImageView.centerY(inView: bottomHorizontalView, leftAnchor: bottomHorizontalView.leftAnchor)
        
        let stack  = UIStackView(arrangedSubviews: [self.stopTimeALabel, self.stopTimeBLabel, self.stopTimeCLabel, UIView()])
        stack.axis = .horizontal
        stack.spacing = 10
        
        bottomHorizontalView.addSubview(stack)
        stack.anchor(top: bottomHorizontalView.topAnchor, left: self.clockImageView.rightAnchor, bottom: bottomHorizontalView.bottomAnchor, right: bottomHorizontalView.rightAnchor, paddingLeft: 5)
    }
    
    private func configure(){
        
        guard let stopTimeCollection = self.stopTimeCollection else {return}
        
        self.viewModel = StopDetailCellViewModel(stopTimeCollection: stopTimeCollection)
        
        guard let viewModel = self.viewModel else {return}
        
        self.originShapeLabel.text = viewModel.shapeOrigin
        self.destinationShapeLabel.text = viewModel.shapeDestination
        
        for index in 0..<viewModel.stopTimesCount {
            switch index {
            case 0:
                stopTimeALabel.text = viewModel.timeStopOfIndex(index)
                stopTimeALabel.textColor = viewModel.textColorOfIndex(index)
            case 1:
                stopTimeBLabel.text = viewModel.timeStopOfIndex(index)
                stopTimeBLabel.textColor = viewModel.textColorOfIndex(index)
            case 2:
                stopTimeCLabel.text = viewModel.timeStopOfIndex(index)
                stopTimeCLabel.textColor = viewModel.textColorOfIndex(index)
                
            default:
                break;
            }
        }
    }
}
