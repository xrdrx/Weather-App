//
//  DetailViewController.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 14.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailView: DetailView
    var viewModel: DetailViewModel
    
    weak var coordinator: MainCoordinator?
    
    init(view: DetailView, viewModel: DetailViewModel) {
        self.detailView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
    }
    
    private func setupViewModel() {
        viewModel.selectedDay.bind { (day) in
            self.updateView()
        }
    }
    
    private func updateView() {
        guard let day = viewModel.selectedDay.value else { return }
        let date = viewModel.dateFormatter.getStringDateFromTimestamp(day.dt)
        
        detailView.dateLabel.text = date
        
        detailView.morningTempLabel.text = String(day.temp.morn)
        detailView.dayTempLabel.text = String(day.temp.day)
        detailView.eveningTempLabel.text = String(day.temp.eve)
        detailView.nightTempLabel.text = String(day.temp.night)
        
        detailView.morningFeelLabel.text = String(day.feelsLike.morn)
        detailView.dayFeelLabel.text = String(day.feelsLike.day)
        detailView.eveningFeelLabel.text = String(day.feelsLike.eve)
        detailView.nightFeelLabel.text = String(day.feelsLike.night)
    }
}
