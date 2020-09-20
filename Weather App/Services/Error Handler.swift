//
//  Error Handler.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 20.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation
import UIKit

class ErrorHandler {
    
    let alert: UIAlertController!
    weak var coordinator: MainCoordinator?
    
    init() {
        self.alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
    }
    
    func notifyAboutError(error: String) {
        alert.title = "Error"
        alert.message = error
        coordinator?.navigationController.present(alert, animated: true, completion: nil)
    }
}
