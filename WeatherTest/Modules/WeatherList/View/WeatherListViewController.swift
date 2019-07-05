//
//  WeatherListViewController.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 03/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol WeatherListViewProtocol: AnyObject {
    
    var presenter: WeatherListPresenterProtocol? { get set }
    
    func reloadTableView()
}

class WeatherListViewController: UIViewController {
    
    var presenter: WeatherListPresenterProtocol?
    
    @IBOutlet weak var addButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = WeatherListPresenter()
        let interactor = WeatherListInteractor()
        let router = WeatherListRouter()
        interactor.presenter = p
        p.interactor = interactor
        p.view = self
        p.router = router
        
        presenter = p
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear()
    }
    
    private func setupViews() {
        
        addButtonItem.setTitleTextAttributes([.font : AppFonts.common, .foregroundColor : AppColors.mainTint.uiColor], for: .normal)
        
        presenter?.registerWeatherListCellFor(tableView: tableView)
    }
}

extension WeatherListViewController: WeatherListViewProtocol {
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
}

extension WeatherListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter?.citiesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return presenter?.getWeatherListCellFor(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
}

extension WeatherListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter?.cellTappedAt(indexPath: indexPath)
    }
}
