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
        stack.spacing = 5
        return stack
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
        
//        let miniParentView = UIView()
        
        let stack = UIStackView(arrangedSubviews: [self.stopShapeLabel,self.stackViewTimeStopsContainer])
        stack.axis = .vertical
        
        self.subParentView.addSubview(stack)
        stack.anchor(top:  self.subParentView.topAnchor, left:  self.subParentView.leftAnchor, bottom:  self.subParentView.bottomAnchor, right:  self.subParentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
        
    
    }
    
    private func configure(){
        self.stopShapeLabel.text = stopTimeCollection?.shape
        
        
        if let stopTimes = self.stopTimeCollection?.stopTimes {
            for stopTime in stopTimes {
                let timeLabelContainer = UIView()
                timeLabelContainer.backgroundColor = .white
             
                timeLabelContainer.setDimensions(height: 40, width: 75)
        
                let label = UILabel()
                label.font = UIFont.systemFont(ofSize: 15)
                label.text = Date.unixTimestampToDateStr(stopTime.departureTimestamp, format: .time)
                label.textColor = .black
                timeLabelContainer.addSubview(label)
                label.centerX(inView: timeLabelContainer)
                label.centerY(inView: timeLabelContainer)
                
                self.stackViewTimeStopsContainer.addArrangedSubview(timeLabelContainer)
            }
            
            let spacer = UIView()
            self.stackViewTimeStopsContainer.addArrangedSubview(spacer)
        }
    }
}
