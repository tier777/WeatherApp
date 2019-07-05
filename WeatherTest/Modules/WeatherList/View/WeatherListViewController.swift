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
    func showAlertFor(error: String)
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
    
    @IBAction func addCityButtonTapped(_ sender: Any) {
        
        presenter?.addCityButtonTapped()
    }
}

extension WeatherListViewController: WeatherListViewProtocol {
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
    
    func showAlertFor(error: String) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true)
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
