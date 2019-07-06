//
//  WeatherImageService.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 04/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherImageServiceProtocol: AnyObject {
    
    static var shared: WeatherImageServiceProtocol { get }
    
    func getIcon(id: String, complition: @escaping (String, UIImage?) -> Void)
}

class WeatherImageService: WeatherImageServiceProtocol {
    
    private init() {}
    
    static let shared: WeatherImageServiceProtocol = WeatherImageService()
    
    private let networkManager = NetworkManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getIcon(id: String, complition: @escaping (String, UIImage?) -> Void) {
        
        let url = OpenWeatherAPI.OpenWeatherImagesAPI.icon(id: id).url
        
        let cachedImage = cache.object(forKey: id as NSString)
        
        guard cachedImage == nil else {
            
            complition(id, cachedImage)
            
            return
        }
        
        networkManager.get(from: url) {
            result in
            
            switch result {
            case .success(let data):
                
                let image = UIImage(data: data)
                
                if let imageToCache = image {
                
                    self.cache.setObject(imageToCache, forKey: id as NSString)
                }
                
                complition(id, image)
                
            case .failure:
                
                complition(id, nil)
            }
        }
    }
}
