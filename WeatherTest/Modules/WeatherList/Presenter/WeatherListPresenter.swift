//
//  WeatherListPresenter.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherListPresenterProtocol: AnyObject {
    
    var view: WeatherListViewProtocol? { get set }
    var interactor: WeatherListInteractorProtocol? { get set }
    var router: WeatherListRouterProtocol? { get set }
    
    var citiesCount: Int { get }
    
    func viewDidAppear()
    
    func registerWeatherListCellFor(tableView: UITableView)
    func getWeatherListCellFor(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell?
    func cellTappedAt(indexPath: IndexPath)
}

class WeatherListPresenter: WeatherListPresenterProtocol {
    
    weak var view: WeatherListViewProtocol?
    var interactor: WeatherListInteractorProtocol?
    var router: WeatherListRouterProtocol?
    
    var citiesCount: Int {
        
        return interactor?.cities.count ?? 0
    }
    
    private func getCityFor(indexPath: IndexPath) -> City? {
        
        guard citiesCount != 0, indexPath.row < citiesCount, let city = interactor?.cities[indexPath.row] else { return nil }
        
        return city
    }
    
    func viewDidAppear() {
        
        guard let interactor = interactor, interactor.cities.isEmpty else { return }
        
        interactor.fetchCities()
    }
    
    func registerWeatherListCellFor(tableView: UITableView) {
        
        WeatherListCellRouter.registerWeatherListCellModuleFor(tableView: tableView)
    }
    
    func getWeatherListCellFor(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        
        guard let city = getCityFor(indexPath: indexPath) else { return nil }
        
        return WeatherListCellRouter.buildWeatherListCellModule(city: city, tableView: tableView, indexPath: indexPath)
    }
    
    func cellTappedAt(indexPath: IndexPath) {
        
        guard let view = view, let city = getCityFor(indexPath: indexPath) else { return }
        
        router?.presentWeatherDetailsModule(from: view, for: city)
    }
}

extension WeatherListPresenter: WeatherListInteractorDelegate {
    
    func didFetchCities() {
        
        if let _ = interactor?.cities.first(where: { $0.isCurrent }) {
            
            view?.reloadTableView()
            
        } else {
            
            interactor?.addCityByCurrentLocation()
        }
    }
    
    func willAddCity() {
        
    }
    
    func didAdd(city: City?) {
        
        view?.reloadTableView()
    }
    
    func on(error: Error) {
        
        //TODO: show error
    }
}
