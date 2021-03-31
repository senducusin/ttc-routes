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
    
    static let cellIdentifier = "StopListTableViewCell"
    
    private let noBusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "No available bus"
        return label
    }()
    
    private let routeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
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
    
    // MARK: - Helpers
    private func configure(){
        
        let viewModel = StopListCellViewModel(route: route)
        
        self.accessoryType = viewModel.routePropertyIsHidden ? .none : .disclosureIndicator
        
        if let parentStack = self.parentStack {
            parentStack.isHidden = viewModel.routePropertyIsHidden
        }
        
        self.noBusLabel.isHidden = viewModel.noBusIsHidden
        self.busImage.isHidden = viewModel.routePropertyIsHidden
        routeNameLabel.text = viewModel.routeName
        
        
        if let nextStop = viewModel.nextStop {
            self.nextBusLabelDestination.text = nextStop.shape
            self.nextBusLabelDeparture.text = Date.unixTimestampToDateStr(nextStop.departureTimestamp, format: .time)
            self.nextBusLabelDeparture.textColor = viewModel.departureTimeColor(stop: nextStop)
        }
    }
    
    private func setupUI(){
        self.addSubview(self.busImage)
        self.busImage.setDimensions(height: 30, width: 30)
        self.busImage.centerY(inView: self, leftAnchor: self.leftAnchor, paddingLeft: 17)
        
        let nextBusStack = UIStackView(arrangedSubviews: [ self.nextBusLabelDeparture, self.nextBusLabelDestination])
        nextBusStack.axis = .vertical
        
        self.parentStack = UIStackView(arrangedSubviews: [self.routeNameLabel, nextBusStack])
        
        if let parentStack = self.parentStack {
            self.addSubview(parentStack)
            parentStack.axis = .vertical
            parentStack.spacing = 7
            parentStack.centerY(inView: self, leftAnchor: self.busImage.rightAnchor, paddingLeft: 5)
        }
        
        self.setupNoBusLabel()
    }
    
    private func setupNoBusLabel(){
        self.addSubview(noBusLabel)
        self.noBusLabel.centerY(inView: self,leftAnchor: self.leftAnchor, paddingLeft: 17)
    }
}
