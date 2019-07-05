//
//  WeatherListCellInteractor.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation
import class UIKit.UIImage

protocol WeatherListCellInteractorProtocol: AnyObject {
    
    var presenter: WeatherListCellInteractorDelegate? { get set }
    
    var city: City? { get }
    
    func loadImage()
}

protocol WeatherListCellInteractorDelegate: AnyObject {
    
    func didSet(city: City?)
    func didLoad(image: UIImage?)
}

class WeatherListCellInteractor: WeatherListCellInteractorProtocol {
    
    weak var presenter: WeatherListCellInteractorDelegate?
    
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
