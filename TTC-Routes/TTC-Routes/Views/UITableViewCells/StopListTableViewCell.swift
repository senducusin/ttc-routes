//
//  StopListTableViewCell.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import UIKit

class StopListTableViewCell: UITableViewCell {
    // MARK: - Properties
    var route:Route? {
        didSet{
            self.configure()
        }
    }
    
    var viewModel: StopListCellViewModel?
    
    static let cellIdentifier = "StopListTableViewCell"
    
    let subParentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.themeCosmos.cgColor
        
        return view
    }()
    
    private let noBusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .themeBrinkPink
        label.text = "No available bus"
        label.textAlignment = .center
        return label
    }()
    
    private let routeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .themeMonza
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let nextBusLabelDestination: SmallCellLabel = {
        return SmallCellLabel()
    }()
    
    private let nextBusLabelDeparture: SmallCellLabel = {
        return SmallCellLabel()
    }()
    
    private let busImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bus.fill")
        imageView.tintColor = .themeBrinkPink
        return imageView
    }()
    
    private let speedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speedometer")
        imageView.tintColor = .darkGray
        imageView.isHidden = false
        return imageView
    }()
    
    private var parentStack: UIStackView?
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        guard let viewModel = self.viewModel else {return}
        
        self.subParentView.layer.borderColor = viewModel.setSubParentViewBorderColor(isHighlighted: highlighted)
        self.subParentView.layer.borderWidth = viewModel.setSubParentViewBorderWidth(isHighlighted: highlighted)
    }
    
    // MARK: - Helpers
    private func configure(){
        
        self.viewModel = StopListCellViewModel(route: route)
        
        guard let viewModel = self.viewModel else {return}
        
        self.accessoryType = viewModel.routePropertyIsHidden ? .none : .disclosureIndicator
        
        if let parentStack = self.parentStack {
            parentStack.isHidden = viewModel.routePropertyIsHidden
        }
        
        self.subParentView.isHidden = !viewModel.noBusIsHidden
        self.noBusLabel.isHidden = viewModel.noBusIsHidden
        self.busImage.isHidden = viewModel.routePropertyIsHidden
        self.nextBusLabelDeparture.text = viewModel.departureTimestampString
        
        routeNameLabel.text = viewModel.routeName
        
        self.nextBusLabelDestination.text = viewModel.shapeDestination
        self.speedImage.isHidden = viewModel.departureIconVisibility
    }
    
    private func setupUI(){
        self.selectionStyle = .none
        
        self.addSubview(self.subParentView)
        self.subParentView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        self.subParentView.addSubview(self.busImage)
        self.busImage.setDimensions(height: 30, width: 30)
        self.busImage.centerY(inView: self, leftAnchor: self.subParentView.leftAnchor, paddingLeft: 17)
        
        let timeStack = UIStackView(arrangedSubviews: [self.nextBusLabelDeparture, self.speedImage, UIView()])
        timeStack.axis = .horizontal
        timeStack.spacing = 5
        self.speedImage.setDimensions(height: 15, width: 15)
        
        let nextBusStack = UIStackView(arrangedSubviews: [self.nextBusLabelDestination, timeStack])
        nextBusStack.axis = .vertical
        nextBusStack.spacing = 5
        
        self.parentStack = UIStackView(arrangedSubviews: [self.routeNameLabel, nextBusStack])
        
        if let parentStack = self.parentStack {
            self.subParentView.addSubview(parentStack)
            parentStack.axis = .vertical
            parentStack.spacing = 7
            
            parentStack.centerY(inView: self, leftAnchor: self.busImage.rightAnchor, paddingLeft: 10)
            parentStack.anchor(right:self.subParentView.rightAnchor, paddingRight: 14)
        }
        
        self.setupNoBusLabel()
    }
    
    private func setupNoBusLabel(){
        self.addSubview(noBusLabel)
        self.noBusLabel.centerY(inView: self,leftAnchor: self.leftAnchor, paddingLeft: 17)
        self.noBusLabel.anchor(right:self.rightAnchor, paddingRight: 17)
    }
}
