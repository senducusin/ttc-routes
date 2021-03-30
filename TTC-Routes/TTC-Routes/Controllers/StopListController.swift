//
//  StopListController.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import UIKit

class StopListController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let resource = StopResponse.all() {
            WebService().load(resource: resource) { result in
                switch result {
                case .success(let stopResponse):
                print(stopResponse)
                
                case .failure(let error):
                print(error.localizedDescription)
                }
            }
        }
        
        
    }
    
}
