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

struct AppFonts {
    
    static let title1 = UIFont.systemFont(ofSize: 32, weight: .bold)
    static let title2 = UIFont.systemFont(ofSize: 32, weight: .semibold)
    static let title3 = UIFont.systemFont(ofSize: 32, weight: .medium)
    static let subtitle = UIFont.systemFont(ofSize: 24, weight: .bold)
    static let common = UIFont.systemFont(ofSize: 18, weight: .semibold)
}
