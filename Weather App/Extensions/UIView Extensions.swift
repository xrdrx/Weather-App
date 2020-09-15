//
//  UIView Extensions.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 13.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

extension UIView {
        
    func setTopAnchorEqualTo(_ top: NSLayoutYAxisAnchor, _ const: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: top, constant: const).isActive = true
    }
    
    func setBottomAnchorEqualTo(_ bottom: NSLayoutYAxisAnchor, _ const: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: bottom, constant: const).isActive = true
    }
    
    func setLeadingAnchorEqualTo(_ leading: NSLayoutXAxisAnchor, _ const: CGFloat = 0) {
        self.leadingAnchor.constraint(equalTo: leading, constant: const).isActive = true
    }
    
    func setTrailingAnchorEqualTo(_ trailing: NSLayoutXAxisAnchor, _ const: CGFloat = 0) {
        self.trailingAnchor.constraint(equalTo: trailing, constant: const).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func turnOffMaskTranslation() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
