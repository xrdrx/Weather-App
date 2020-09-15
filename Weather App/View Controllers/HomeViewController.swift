//
//  HomeViewController.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var homeView: HomeView
    var viewModel: HomeViewModel
    
    weak var coordinator: MainCoordinator?
    
    var searchField: UITextField!
    var searchTable: UITableView!
    var weatherTable: UITableView!

    init(viewModel: HomeViewModel, view: HomeView) {
        self.viewModel = viewModel
        self.homeView = view
        
        
        
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.searchField = homeView.searchField
        self.weatherTable = homeView.weatherTable
        self.searchTable = homeView.searchTable
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        searchTable.isHidden = true
    }
    
    private func setupViewModel() {
        viewModel.selectedDay.bind { (day) in
            let detailVC = self.coordinator?.presentDetailView()
            detailVC!.viewModel.selectedDay.value = day
        }
    }
    
    private func setupTableView() {
        searchTable.delegate = self
        searchTable.dataSource = self
        searchTable.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
        
        weatherTable.delegate = viewModel
        weatherTable.dataSource = viewModel
        weatherTable.register(UITableViewCell.self, forCellReuseIdentifier: "DayCell")
    }
    
    private func setupUiElements() {
        searchField.addTarget(self, action: #selector(searchFieldValueChanged), for: .editingChanged)
        searchField.addTarget(self, action: #selector(startedEditingSearchField), for: .editingDidBegin)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = viewModel.filteredPlaces[indexPath.row]
        
        cell.textLabel?.text = "\(place.name)"
        if place.state != .empty { cell.textLabel?.text = cell.textLabel!.text! + ", \(place.state.rawValue)" }
        if place.country != .empty { cell.textLabel?.text = cell.textLabel!.text! + ", \(place.country.rawValue)" }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = viewModel.filteredPlaces[indexPath.row]
        searchField.text = "\(place.name)"
        if place.state != .empty { searchField.text = searchField.text! + ", \(place.state.rawValue)" }
        if place.country != .empty { searchField.text = searchField.text! + ", \(place.country.rawValue)" }
        tableView.deselectRow(at: indexPath, animated: false)
        homeView.searchTable.isHidden = true
        viewModel.selectedPlace = place
        viewModel.getWeatherForecast { self.reloadWeatherTable() }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func searchFieldValueChanged() {
        showSearchTable()
        if let text = searchField.text {
            viewModel.filterPlacesBy(text)
            searchTable.reloadData()
        }
    }
    
    @objc func startedEditingSearchField() {
        showSearchTable()
    }
    
    @objc func endedEditingSearchField() {
        hideSearchTable()
    }
    
    private func reloadWeatherTable() {
        DispatchQueue.main.async {
            self.weatherTable.reloadData()
        }
    }
    private func showSearchTable() {
        homeView.searchTable.isHidden = false
    }
    
    private func hideSearchTable() {
        homeView.searchTable.isHidden = true
    }
}
