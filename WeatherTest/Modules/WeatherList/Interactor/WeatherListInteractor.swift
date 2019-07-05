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
    func updateAllCities()
    func update(city: City)
}

protocol WeatherListInteractorDelegate: AnyObject {
    
    func didFetchCities()
    
    func willUpdate(city: City)
    func didUpdate(city: City)
    
    func willAddCity()
    func didAdd(city: City?)
    func on(error: Error)
}

class WeatherListInteractor {
    
    weak var presenter: WeatherListInteractorDelegate?
    
    private let defaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager.shared
    private let locationManager: LocationManagerProtocol = LocationManager.shared
    private let weatherService: WeatherServiceProtocol = WeatherService()
    
    var cities: [City] = []
    
    private func saveCities() {
        
        defaultsManager.save(cities: cities)
    }
    
    private func addOrUpdate(city: City) {
        
        if let index = self.cities.firstIndex(where: { $0.id == city.id }) {
            
            self.cities[index] = city
            
        } else {
            
            self.cities.append(city)
        }
        
        cities.sort(by: { $0.isCurrent && !$1.isCurrent })
        
        self.saveCities()
    }
}

extension WeatherListInteractor: WeatherListInteractorProtocol {
    
    func fetchCities() {
        
        cities = defaultsManager.getCities()
        
        presenter?.didFetchCities()
    }
    
    func updateAllCities() {
        
        for city in cities {
            
            update(city: city)
        }
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
                            
                            self.addOrUpdate(city: city)
                            
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
                
                self.addOrUpdate(city: city)
                
                self.presenter?.didAdd(city: city)
                
            case .failure(let error):
                
                self.presenter?.on(error: error)
            }
        })
    }
    
    func update(city: City) {
        
        guard let name = city.name else { return }
        
        self.presenter?.willUpdate(city: city)
        
        self.weatherService.getForecastByCity(name: name, complition: {
            result in
            
            switch result {
            case .success(var updatedCity):
                
                updatedCity.isCurrent = city.isCurrent
                
                self.addOrUpdate(city: updatedCity)
                
                self.presenter?.didUpdate(city: updatedCity)
                
            case .failure(let error):
                
                self.presenter?.on(error: error)
            }
        })
    }
}
