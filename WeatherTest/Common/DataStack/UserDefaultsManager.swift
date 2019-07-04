//
//  UserDefaultsManager.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 04/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    
    static var shared: UserDefaultsManagerProtocol { get }
    
    func save(cities: [City])
    func getCities() -> [City]
}

class UserDefaultsManager {
    
    enum Keys {
        
        static let cities = "cities"
    }
    
    private init() {}
    
    static let shared: UserDefaultsManagerProtocol = UserDefaultsManager()
    
    private var defaults: UserDefaults {
        
        return UserDefaults.standard
    }
}

extension UserDefaultsManager: UserDefaultsManagerProtocol {
    
    func save(cities: [City]) {
        
        let dataArray: [Data] = cities.compactMap {
            city in
            
            guard let encoded = try? JSONEncoder().encode(city) else { return nil }
            
            return encoded
        }
        
        defaults.set(dataArray, forKey: Keys.cities)
    }
    
    func getCities() -> [City] {
        
        guard let dataArray = defaults.array(forKey: Keys.cities) as? [Data] else { return [] }
        
        let cities: [City] = dataArray.compactMap {
            data in
            
            guard let decoded = try? JSONDecoder().decode(City.self, from: data) else { return nil }
            
            return decoded
        }
        
        return cities
    }
}
