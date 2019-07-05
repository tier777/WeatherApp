//
//  WeatherListRouter.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherListRouterProtocol {
    
    static func buildWeatherListModule() -> UIViewController
    
    func presentWeatherDetailsModule(from view: WeatherListViewProtocol, for city: City)
    func presentAddCityModule(from view: WeatherListViewProtocol, delegate: AddCityAlertControllerDelegate?)
}

class WeatherListRouter: WeatherListRouterProtocol {
    
    static func buildWeatherListModule() -> UIViewController {
        
        guard let navigationController = AppStoryboard.weatherList.build().instantiateInitialViewController() as? UINavigationController, let weatherListViewController = navigationController.topViewController as? WeatherListViewController else {
            
            fatalError("Can't build WeatherList module.")
        }
        
        let presenter = WeatherListPresenter()
        let interactor = WeatherListInteractor()
        let router = WeatherListRouter()
        
        weatherListViewController.presenter = presenter
        presenter.view = weatherListViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navigationController
    }
    
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
