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
    
    func addCityButtonTapped()
}

class WeatherListPresenter {
    
    weak var view: WeatherListViewProtocol?
    var interactor: WeatherListInteractorProtocol?
    var router: WeatherListRouterProtocol?
    
    private func getCityFor(indexPath: IndexPath) -> City? {
        
        guard citiesCount != 0, indexPath.row < citiesCount, let city = interactor?.cities[indexPath.row] else { return nil }
        
        return city
    }
}

extension WeatherListPresenter: WeatherListPresenterProtocol {
    
    var citiesCount: Int {
        
        return interactor?.cities.count ?? 0
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
    
    func addCityButtonTapped() {
        
        guard let view = view else { return }
        
        self.router?.presentAddCityModule(from: view, delegate: self)
    }
}

extension WeatherListPresenter: WeatherListInteractorDelegate {
    
    func didFetchCities() {
        
        view?.reloadTableView()
        
        if citiesCount > 0 {
            
            interactor?.updateAllCities()
        }
        
        if interactor?.cities.first(where: { $0.isCurrent }) == nil {
            
            interactor?.addCityByCurrentLocation()
        }
    }
    
    func willAddCity() {
        
        view?.showIndicatorView()
    }
    
    func didAdd(city: City?) {
        
        view?.dismissIndicatorView()
        
        view?.reloadTableView()
    }
    
    func willUpdate(city: City) {
        
    }
    
    func didUpdate(city: City) {
        
        if let index = interactor?.cities.firstIndex(where: { $0.id == city.id }) {
            
            view?.reloadTableViewCell(at: IndexPath(row: index, section: 0))
        }
    }
    
    func on(error: Error) {
        
        view?.dismissIndicatorView()
        
        if let dataError = error as? NetworkDataError, dataError == .noContentError {
            
           view?.showAlertFor(error: "City not found")
        }
    }
}

extension WeatherListPresenter: AddCityAlertControllerDelegate {
    
    func addButtonTapped(fieldInput: String?) {
        
        guard let name = fieldInput else { return }
        
        interactor?.addCityBy(name: name)
    }
}
