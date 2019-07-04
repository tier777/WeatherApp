//
//  WeatherListInteractor.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

protocol WeatherListInteractorProtocol: AnyObject {
    
    var presenter: WeatherListInteractorDelegate? { get set }
    
    func fetchCities()
    var cities: [City] { get }
    
    func addCityByCurrentLocation()
    func addCityBy(name: String)
}

protocol WeatherListInteractorDelegate: AnyObject {
    
    func didFetchCities()
    
    func willAddCity()
    func didAdd(city: City?)
    func on(error: Error)
}

class WeatherListInteractor: WeatherListInteractorProtocol {
    
    weak var presenter: WeatherListInteractorDelegate?
    
    private let defaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager.shared
    private let locationManager: LocationManagerProtocol = LocationManager.shared
    private let weatherService: WeatherServiceProtocol = WeatherService()
    
    var cities: [City] = []
    
    func fetchCities() {
        
        cities = defaultsManager.getCities()
        
        presenter?.didFetchCities()
    }
    
    func addCityByCurrentLocation() {
        
        locationManager.authorizeForLocationUpdates {
            isAuthorized in
            
            self.locationManager.getCurrentLocation() {
                result in
                
                switch result {
                case .success(let location):
                    
                    self.presenter?.willAddCity()
                    
                    self.weatherService.getForecastByLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, complition: {
                        result in
                        
                        switch result {
                        case .success(var city):
                            
                            city.isCurrent = true
                            
                            if let index = self.cities.firstIndex(where: { $0.id == city.id }) {
                                
                                self.cities[index] = city
                                
                            } else {
                                
                                self.cities.insert(city, at: 0)
                            }
                            
                            self.defaultsManager.save(cities: self.cities)
                            
                            self.presenter?.didAdd(city: city)
                            
                        case .failure(let error):
                            
                            self.presenter?.on(error: error)
                        }
                    })
                    
                case .failure(let error):
                    
                    self.presenter?.on(error: error)
                }
            }
        }
    }
    
    func addCityBy(name: String) {
        
        self.presenter?.willAddCity()
        
        self.weatherService.getForecastByCity(name: name, complition: {
            result in
            
            switch result {
            case .success(let city):
                
                self.presenter?.didAdd(city: city)
                
            case .failure(let error):
                
                self.presenter?.on(error: error)
            }
        })
    }
}
