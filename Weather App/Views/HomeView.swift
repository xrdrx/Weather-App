//
//  HomeView.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class HomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        assembleViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assembleViews() {
        addSubview(background)
        addSubview(searchField)
        addSubview(weatherTable)
        addSubview(searchTable)
    }
    
    func setupLayout() {
        background.frame = self.bounds
        background.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        searchField.turnOffMaskTranslation()
        searchField.setTopAnchorEqualTo(safeAreaLayoutGuide.topAnchor, 10)
        searchField.setLeadingAnchorEqualTo(safeAreaLayoutGuide.leadingAnchor, 30)
        searchField.setTrailingAnchorEqualTo(safeAreaLayoutGuide.trailingAnchor, -30)
        searchField.setHeight(50)
        
        searchTable.turnOffMaskTranslation()
        searchTable.setTopAnchorEqualTo(searchField.bottomAnchor, 10)
        searchTable.setLeadingAnchorEqualTo(searchField.leadingAnchor)
        searchTable.setTrailingAnchorEqualTo(searchField.trailingAnchor)
        searchTable.setHeight(150)
        
        weatherTable.turnOffMaskTranslation()
        weatherTable.setTopAnchorEqualTo(searchField.bottomAnchor, 100)
        weatherTable.setLeadingAnchorEqualTo(safeAreaLayoutGuide.leadingAnchor)
        weatherTable.setTrailingAnchorEqualTo(safeAreaLayoutGuide.trailingAnchor)
        weatherTable.setBottomAnchorEqualTo(safeAreaLayoutGuide.bottomAnchor)
    }
    
    let searchField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        return field
    }()
    
    let searchTable: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 6
        table.layer.masksToBounds = true
        table.isHidden = true
        return table
    }()
    
    let weatherTable: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView(frame: .zero)
        table.isHidden = true
        return table
    }()
    
    let background = UIView()
}
