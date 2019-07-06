//
//  WeatherListCellPresenter.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherListCellPresenterProtocol: AnyObject {
    
    var view: WeatherListCellViewProtocol? { get set }
    var interactor: WeatherListCellInteractorProtocol? { get set }
    
    func getCityName() -> String
    func getTemperature() -> String
}

class WeatherListCellPresenter: WeatherListCellPresenterProtocol {
    
    weak var view: WeatherListCellViewProtocol?
    var interactor: WeatherListCellInteractorProtocol?
    
    func getCityName() -> String {
        
        return interactor?.city?.name ?? ""
    }
    
    func getTemperature() -> String {
        
        guard let temperature = interactor?.city?.temperature?.temperature else { return "" }
        
        return "\(Int(temperature))°C"
    }
}

extension WeatherListCellPresenter: WeatherListCellInteractorDelegate {
    
    func didSet(city: City?) {
        
        view?.display(city: getCityName())
        view?.display(temperature: getTemperature())
    }
    
    func didLoad(image: UIImage?) {
        
        view?.display(image: image)
    }
}
