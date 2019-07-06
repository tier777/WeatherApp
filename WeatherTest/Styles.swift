//
//  Styles.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

enum AppColors: String {
    
    case white = "white"
    case black = "black"
    case mainTint = "tintBlue"
    
    var uiColor: UIColor {
        
        return UIColor(named: self.rawValue)!
    }
    
    var cgColor: CGColor {
        
        return uiColor.cgColor
    }
}
