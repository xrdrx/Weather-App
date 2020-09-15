//
//  HomeView.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

let numberOfRows: CGFloat = 7

class HomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(searchField)
        addSubview(searchTable)
        addSubview(weatherTable)
        
        searchField.turnOffMaskTranslation()
        searchField.setTopAnchorEqualTo(safeAreaLayoutGuide.topAnchor, 10)
        searchField.setLeadingAnchorEqualTo(safeAreaLayoutGuide.leadingAnchor, 30)
        searchField.setTrailingAnchorEqualTo(safeAreaLayoutGuide.trailingAnchor, -30)
        searchField.setHeight(50)
        
        searchTable.turnOffMaskTranslation()
        searchTable.setTopAnchorEqualTo(searchField.bottomAnchor)
        searchTable.setLeadingAnchorEqualTo(searchField.leadingAnchor)
        searchTable.setTrailingAnchorEqualTo(searchField.trailingAnchor)
        searchTable.setHeight(150)
        
        weatherTable.turnOffMaskTranslation()
        weatherTable.setTopAnchorEqualTo(searchTable.bottomAnchor, 30)
        weatherTable.setLeadingAnchorEqualTo(safeAreaLayoutGuide.leadingAnchor)
        weatherTable.setTrailingAnchorEqualTo(safeAreaLayoutGuide.trailingAnchor)
        weatherTable.setBottomAnchorEqualTo(safeAreaLayoutGuide.bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let searchField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        return field
    }()
    
    let searchTable: UITableView = {
        let table = UITableView()
        table.isHidden = true
        return table
    }()
    
    let weatherTable: UITableView = {
        let table = UITableView()
        return table
    }()
}
