//
//  WeatherDetailsPresenter.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherDetailsPresenterProtocol: AnyObject {
    
    var view: WeatherDetailsViewProtocol? { get set }
    var interactor: WeatherDetailsInteractorProtocol? { get set }
    var router: WeatherDetailsRouterProtocol? { get set }
    
    func viewDidAppear()
    
    func closeButtonTapped()
    
    func getCityName() -> String
    func getTemperature() -> String
    func getWindDirection() -> String
}

class WeatherDetailsPresenter: WeatherDetailsPresenterProtocol {
    
    weak var view: WeatherDetailsViewProtocol?
    var interactor: WeatherDetailsInteractorProtocol?
    var router: WeatherDetailsRouterProtocol?
    
    func viewDidAppear() {
        
        if let angle = interactor?.city?.wind?.direction {
            
            view?.showWindDirection(angle: CGFloat(angle))
        }
    }
    
    func closeButtonTapped() {
        
        guard let view = view else { return }
        
        router?.navigateBackToWeatherListModule(from: view)
    }
    
    func getCityName() -> String {
        
        return interactor?.city?.name ?? ""
    }
    
    func getTemperature() -> String {
        
        guard let temperature = interactor?.city?.temperature?.temperature else { return "" }
        
        return "\(Int(temperature))°C"
    }
    
    func getWindDirection() -> String {
        
        guard let degrees = interactor?.city?.wind?.direction else { return "" }
        
        return WindDirections(windDegrees: degrees).abbreviation
    }
}

extension WeatherDetailsPresenter: WeatherDetailsInteractorDelegate {
    
    func didSet(city: City?) {
        
        view?.display(city: getCityName())
        view?.display(temperature: getTemperature())
        view?.displayWind(direction: getWindDirection())
    }
    
    func didLoad(image: UIImage?) {
        
        view?.display(image: image)
    }
}
