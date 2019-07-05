//
//  WeatherDetailsInteractor.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation
import class UIKit.UIImage

protocol WeatherDetailsInteractorProtocol: AnyObject {
    
    var presenter: WeatherDetailsInteractorDelegate? { get set }
    
    var city: City? { get }
}

protocol WeatherDetailsInteractorDelegate: AnyObject {
    
    func didSet(city: City?)
    func didLoad(image: UIImage?)
}

class WeatherDetailsInteractor: WeatherDetailsInteractorProtocol {
    
    weak var presenter: WeatherDetailsInteractorDelegate?
    
    private let imageService = WeatherImageService.shared
    
    var city: City? {
        
        didSet {
            
            presenter?.didSet(city: city)
            
            loadImage()
        }
    }
    
    func loadImage() {
        
        if let iconId = city?.weather.first?.iconId {
            
            imageService.getIcon(id: iconId) {
                loadedIconId, image in
                
                if loadedIconId == iconId {
                    
                    self.presenter?.didLoad(image: image)
                }
            }
        }
    }
}
