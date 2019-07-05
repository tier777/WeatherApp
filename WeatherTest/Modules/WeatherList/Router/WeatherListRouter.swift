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
    func presentAddCityModule(from view: WeatherListViewProtocol, delegate: AddCityAlertControllerDelegate?)
}

class WeatherListRouter: WeatherListRouterProtocol {
    
    func presentWeatherDetailsModule(from view: WeatherListViewProtocol, for city: City) {
        
        guard let viewController = view as? UIViewController else { return }
        
        let weatherDetailsViewController = WeatherDetailsRouter.buildWeatherDetailsModule(city: city)
        
        viewController.present(weatherDetailsViewController, animated: true)
    }
    
    func presentAddCityModule(from view: WeatherListViewProtocol, delegate: AddCityAlertControllerDelegate?) {
        
        guard let viewController = view as? UIViewController else { return }
        
        let addCityAlert = AddCityRouter.buildAddCityModule(delegate: delegate)
        
        viewController.present(addCityAlert, animated: true)
    }
}
