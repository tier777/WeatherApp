//
//  AppStoryboards.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    
    case weatherList = "WeatherList"
    case weatherDetails = "WeatherDetails"
    
    func build() -> UIStoryboard {
        
        return UIStoryboard(name: rawValue, bundle: nil)
    }
}
