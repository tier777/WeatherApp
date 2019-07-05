//
//  WeatherDetailsPresenter.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

protocol WeatherDetailsPresenterProtocol: AnyObject {
    
    var view: WeatherDetailsViewProtocol? { get set }
    var interactor: WeatherDetailsInteractorProtocol? { get set }
    
}

class WeatherDetailsPresenter: WeatherDetailsPresenterProtocol {
    
    weak var view: WeatherDetailsViewProtocol?
    var interactor: WeatherDetailsInteractorProtocol?
}
