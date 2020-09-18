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
        
        detailView.morningTempLabel.text = day.temp.morn.rounded().description
        detailView.dayTempLabel.text = day.temp.day.rounded().description
        detailView.eveningTempLabel.text = day.temp.eve.rounded().description
        detailView.nightTempLabel.text = day.temp.night.rounded().description
        
        detailView.morningFeelLabel.text = day.feelsLike.morn.rounded().description
        detailView.dayFeelLabel.text = day.feelsLike.day.rounded().description
        detailView.eveningFeelLabel.text = day.feelsLike.eve.rounded().description
        detailView.nightFeelLabel.text = day.feelsLike.night.rounded().description
    }
}
