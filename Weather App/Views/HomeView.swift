//
//  HomeView.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 12.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
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
        table.rowHeight = 55
        table.tableFooterView = UIView(frame: .zero)
        table.isHidden = true
        return table
    }()
    
    let background = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        assembleViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func assembleViews() {
        addSubview(background)
        addSubview(searchField)
        addSubview(weatherTable)
        addSubview(searchTable)
    }
    
    private func setupLayout() {
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
}

class WeatherTableViewCell: UITableViewCell {
    
    let weatherImage = UIImageView()
    let mainLabel = UILabel()
    let secondaryLabel = UILabel()
    let dayTemp = UILabel()
    let nightTemp = UILabel()
    
    override init(style: UITableViewCell.CellStyle,
         reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        assembleViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupLabel(label: mainLabel, font: UIFont.systemFont(ofSize: 20, weight: .semibold), alignment: .left)
        setupLabel(label: secondaryLabel, font: UIFont.systemFont(ofSize: 15, weight: .regular), alignment: .left)
        setupLabel(label: dayTemp, font: UIFont.systemFont(ofSize: 20, weight: .semibold), alignment: .right)
        setupLabel(label: nightTemp, font: UIFont.systemFont(ofSize: 15, weight: .regular), alignment: .right)
    }
    
    private func setupLabel(label: UILabel, font: UIFont, alignment: NSTextAlignment) {
        label.font = font
        label.textAlignment = alignment
    }
    
    private func assembleViews() {
        addSubview(weatherImage)
        addSubview(mainLabel)
        addSubview(secondaryLabel)
        addSubview(dayTemp)
        addSubview(nightTemp)
    }
    
    private func setupLayout() {
        weatherImage.turnOffMaskTranslation()
        weatherImage.setTopAnchorEqualTo(self.topAnchor)
        weatherImage.setBottomAnchorEqualTo(self.bottomAnchor)
        weatherImage.setTrailingAnchorEqualTo(self.trailingAnchor, -10)
        NSLayoutConstraint(item: weatherImage, attribute: .height, relatedBy: .equal, toItem: weatherImage, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        mainLabel.turnOffMaskTranslation()
        mainLabel.setTopAnchorEqualTo(self.topAnchor)
        mainLabel.setLeadingAnchorEqualTo(self.leadingAnchor, 10)
        mainLabel.setBottomAnchorEqualTo(secondaryLabel.topAnchor)
        
        secondaryLabel.turnOffMaskTranslation()
        secondaryLabel.setLeadingAnchorEqualTo(mainLabel.leadingAnchor)
        secondaryLabel.setBottomAnchorEqualTo(self.bottomAnchor)
        secondaryLabel.setTrailingAnchorEqualTo(mainLabel.trailingAnchor)
        
        nightTemp.turnOffMaskTranslation()
        nightTemp.setTrailingAnchorEqualTo(weatherImage.leadingAnchor, -10)
        nightTemp.setTopAnchorEqualTo(self.topAnchor)
        nightTemp.setBottomAnchorEqualTo(self.bottomAnchor)
        nightTemp.setWidth(50)
        
        dayTemp.turnOffMaskTranslation()
        dayTemp.setLeadingAnchorEqualTo(mainLabel.trailingAnchor)
        dayTemp.setTopAnchorEqualTo(self.topAnchor)
        dayTemp.setBottomAnchorEqualTo(self.bottomAnchor)
        dayTemp.setTrailingAnchorEqualTo(nightTemp.leadingAnchor, -10)
        dayTemp.setWidth(50)
    }
}
