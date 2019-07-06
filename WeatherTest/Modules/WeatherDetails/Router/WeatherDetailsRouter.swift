//
//  WeatherDetailsRouter.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherDetailsRouterProtocol: AnyObject {
    
    static func buildWeatherDetailsModule(city: City) -> UIViewController
    
    func navigateBackToWeatherListModule(from view: WeatherDetailsViewProtocol)
}

class WeatherDetailsRouter: WeatherDetailsRouterProtocol {
    
    static func buildWeatherDetailsModule(city: City) -> UIViewController {
        
        guard let weatherDetailsViewController = AppStoryboard.weatherDetails.build().instantiateInitialViewController() as? WeatherDetailsViewController else {
            
            fatalError("Can't build WeatherDetails module.")
        }
        
        let presenter = WeatherDetailsPresenter()
        let interactor = WeatherDetailsInteractor()
        let router = WeatherDetailsRouter()
        
        weatherDetailsViewController.presenter = presenter
        presenter.view = weatherDetailsViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.city = city
        
        return weatherDetailsViewController
    }
    
    func navigateBackToWeatherListModule(from view: WeatherDetailsViewProtocol) {
        
        guard let viewController = view as? UIViewController else { return }
        
        viewController.dismiss(animated: true)
    }
}
