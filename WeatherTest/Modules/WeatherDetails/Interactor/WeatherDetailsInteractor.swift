//
//  WeatherDetailsInteractor.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

protocol WeatherDetailsInteractorProtocol: AnyObject {
    
    var presenter: WeatherDetailsInteractorDelegate? { get set }
}

protocol WeatherDetailsInteractorDelegate: AnyObject {
    
}

class WeatherDetailsInteractor: WeatherDetailsInteractorProtocol {
    
    weak var presenter: WeatherDetailsInteractorDelegate?
}
