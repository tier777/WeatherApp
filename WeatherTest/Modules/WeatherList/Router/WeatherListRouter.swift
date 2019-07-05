//
//  WeatherListRouter.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherListRouterProtocol {
    
    
    func presentWeatherDetailsModule(from view: WeatherListViewProtocol, for city: City)
}

class WeatherListRouter: WeatherListRouterProtocol {
    
    func presentWeatherDetailsModule(from view: WeatherListViewProtocol, for city: City) {
        
        guard let viewController = view as? UIViewController else { return }
        
        let weatherDetailsViewController = WeatherDetailsRouter.buildWeatherDetailsModule(city: city)
        
        viewController.present(weatherDetailsViewController, animated: true)
    }
}
