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
        
        searchField.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)
        
        searchTable.anchor(top: searchField.bottomAnchor, leading: searchField.leadingAnchor, bottom: nil, trailing: searchField.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        weatherTable.anchor(top: searchTable.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
