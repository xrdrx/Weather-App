//
//  HomeViewController.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var homeView: HomeView
    var viewModel: HomeViewModel
    
    weak var coordinator: MainCoordinator?
    
    var searchField: UITextField!
    var searchTable: UITableView!
    var weatherTable: UITableView!
    var background: UIView!

    init(viewModel: HomeViewModel, view: HomeView) {
        self.viewModel = viewModel
        self.homeView = view
        
        super.init(nibName: nil, bundle: nil)
        self.searchField = homeView.searchField
        self.weatherTable = homeView.weatherTable
        self.searchTable = homeView.searchTable
        self.background = homeView.background
        
        setupViewModel()
        setupTableView()
        setupUiElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
    }
    
    private func setupViewModel() {
        viewModel.selectedDay.bind { (day) in
            let detailVC = self.coordinator?.presentDetailView()
            detailVC!.viewModel.selectedDay.value = day
        }
        
        viewModel.error.bind { (error) in
            DispatchQueue.main.async {
                self.coordinator?.presentAlert(message: error)
            }
        }
    }
    
    private func setupTableView() {
        searchTable.delegate = self
        searchTable.dataSource = self
        searchTable.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
        
        weatherTable.delegate = viewModel
        weatherTable.dataSource = viewModel
        weatherTable.register(WeatherTableViewCell.self, forCellReuseIdentifier: "DayCell")
    }
    
    private func setupUiElements() {
        searchField.addTarget(self, action: #selector(searchFieldValueChanged), for: .editingChanged)
        searchField.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPlacesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = viewModel.getPlace(forRow: indexPath.row)
        cell.textLabel?.text = viewModel.getPlaceDescription(place)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = viewModel.getPlace(forRow: indexPath.row)
        searchField.text = viewModel.getPlaceDescription(place)
        searchField.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: false)
        hideSearchTable()
        viewModel.selectedPlace = place
        viewModel.getWeatherForecast { self.showAndReloadWeatherTable() }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func searchFieldValueChanged() {
        if let text = searchField.text {
            viewModel.setFilteredPlaces(filterString: text)
            searchTable.reloadData()
        }
    }
    
    private func showAndReloadWeatherTable() {
        DispatchQueue.main.async {
            self.weatherTable.isHidden = false
            self.weatherTable.reloadData()
        }
    }
    
    private func showSearchTable() {
        DispatchQueue.main.async {
            self.searchTable.isHidden = false
        }
    }
    
    private func hideSearchTable() {
        DispatchQueue.main.async {
            self.searchTable.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            textField.text = ""
            self.showSearchTable()
            self.weatherTable.addBlur()
            self.background.addBlur()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.weatherTable.removeVisualEffects()
            self.background.removeVisualEffects()
        }
    }
}
