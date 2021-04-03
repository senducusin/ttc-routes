//
//  SettingsViewModel.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 4/3/21.
//

import UIKit

struct SettingsViewModel {
    
    private var cornerRadiusLarge:CGFloat = 0
    private var cornerRadiusSmall:CGFloat = 0
    private var rawCornerRadius:CGFloat = 0
    
    mutating func setRawCornerRadius(_ cornerRadius:CGFloat){
        rawCornerRadius = cornerRadius
        
        if cornerRadiusLarge == 0 && cornerRadiusSmall == 0 {
            cornerRadiusLarge = cornerRadius
        } else if cornerRadiusLarge > 0 && cornerRadiusSmall == 0 && rawCornerRadius != cornerRadiusLarge {
            cornerRadiusSmall = cornerRadius
        }
}
    
    var cornerRadius:CGFloat {
        if cornerRadiusSmall > 0 && cornerRadiusLarge > 0{
            switch UIDevice.current.orientation {
            case .portrait:
                return  cornerRadiusLarge
            case .landscapeLeft, .landscapeRight:
                return cornerRadiusSmall
           
            default: break
            }
        }
        
        return rawCornerRadius
    }

}
