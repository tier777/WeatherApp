//
//  WeatherListCellRouter.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherListCellRouterProtocol: AnyObject {
    
    static func registerWeatherListCellModuleFor(tableView: UITableView)
    static func buildWeatherListCellModule(city: City?, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell?
}

class WeatherListCellRouter: WeatherListCellRouterProtocol {
    
    private static let identifier = "WeatherListCell"
    
    static func registerWeatherListCellModuleFor(tableView: UITableView) {
        
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    static func buildWeatherListCellModule(city: City?, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? WeatherListCell else { return nil }
        
        let interactor = WeatherListCellInteractor()
        let presenter = WeatherListCellPresenter()
        
        cell.presenter = presenter
        presenter.view = cell
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.city = city
        
        return cell
    }
}
