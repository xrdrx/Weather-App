//
//  MainCoordinator.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let factory: Factory

    init(navigationController: UINavigationController, factory: Factory) {
        self.navigationController = navigationController
        self.factory = factory
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
    }
    
    func start() {
        let vc = factory.makeHomeViewController()
        vc.coordinator = self
        vc.title = "Weather"
        navigationController.pushViewController(vc, animated: false)
    }
    
    func presentDetailView() -> DetailViewController {
        let vc = factory.makeDetailViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        return vc
    }
    
    func presentAlert(message: String) {
        let alert = factory.makeErrorHandler()
        alert.coordinator = self
        alert.notifyAboutError(error: message)
    }
}
