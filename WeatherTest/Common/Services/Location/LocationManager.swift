//
//  LocationManager.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import CoreLocation

enum LocationManagerError: Error {
    
    case notAuthorized
}

protocol LocationManagerProtocol: AnyObject {
    
    static var shared: LocationManagerProtocol { get }
    
    func authorizeForLocationUpdates(complition: @escaping (Bool) -> Void)
    func getCurrentLocation(complition: @escaping (Result<CLLocation, Error>) -> Void)
}

class LocationManager: NSObject {
    
    static let shared: LocationManagerProtocol = LocationManager()
    
    private var manager: CLLocationManager!
    private var authorizationStatus: CLAuthorizationStatus {
        
        return CLLocationManager.authorizationStatus()
    }
    
    private var statusComplition: ((Bool) -> Void)?
    private var locationUpdateComplition: ((Result<CLLocation, Error>) -> Void)?
    
    private override init() {
        super.init()
        
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.delegate = self
        
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: LocationManagerProtocol {
    
    func authorizeForLocationUpdates(complition: @escaping (Bool) -> Void) {
        
        guard authorizationStatus != .authorizedWhenInUse else {
            
            complition(true)
            
            return
        }
        
        self.statusComplition = complition
        
        manager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation(complition: @escaping (Result<CLLocation, Error>) -> Void) {
        
        guard authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse else {
            
            complition(.failure(LocationManagerError.notAuthorized))
            
            return
        }
        
        self.locationUpdateComplition = complition
        
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard let complition = statusComplition else { return }
        
        complition(status == .authorizedWhenInUse)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        if let complition = locationUpdateComplition {
            
            complition(.success(location))
        }
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("LocationManager error: \(error.localizedDescription)")
        
        if let complition = locationUpdateComplition {
            
            complition(.failure(error))
        }
    }
}
