//
//  DetailView.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 14.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class DetailView: UIView {

    let bigFont = UIFont.systemFont(ofSize: 30, weight: .regular)
    let smallFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    
    var verticalStackView: UIStackView!
    
    var dateLabel: UILabel!
    
    var dayTimeStack: UIStackView!
    var morningLabel: UILabel!
    var dayLabel: UILabel!
    var eveningLabel: UILabel!
    var nightLabel: UILabel!
    
    var feelsLikeLabel: UILabel!
    
    var tempStack: UIStackView!
    var morningTempLabel: UILabel!
    var dayTempLabel: UILabel!
    var eveningTempLabel: UILabel!
    var nightTempLabel: UILabel!
    
    var feelStack: UIStackView!
    var morningFeelLabel: UILabel!
    var dayFeelLabel: UILabel!
    var eveningFeelLabel: UILabel!
    var nightFeelLabel: UILabel!
    
    var delimeter: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        createViews()
        assembleViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        verticalStackView = createVerticalStackView()
        
        dateLabel = createLabel(text: "Date", font: bigFont)
        
        dayTimeStack = createHorizontalStackView()
        morningLabel = createLabel(text: "Morning", color: .lightGray, font: smallFont)
        dayLabel = createLabel(text: "Day", color: .lightGray, font: smallFont)
        eveningLabel = createLabel(text: "Evening", color: .lightGray, font: smallFont)
        nightLabel = createLabel(text: "Night", color: .lightGray, font: smallFont)
        
        tempStack = createHorizontalStackView()
        morningTempLabel = createLabel(text: "test", font: smallFont)
        dayTempLabel = createLabel(text: "test", font: smallFont)
        eveningTempLabel = createLabel(text: "test", font: smallFont)
        nightTempLabel = createLabel(text: "test", font: smallFont)
        
        feelsLikeLabel = createLabel(text: "Feels like", color: .lightGray, font: smallFont)
        
        feelStack = createHorizontalStackView()
        morningFeelLabel = createLabel(text: "test", font: smallFont)
        dayFeelLabel = createLabel(text: "test", font: smallFont)
        eveningFeelLabel = createLabel(text: "test", font: smallFont)
        nightFeelLabel = createLabel(text: "test", font: smallFont)
        
        delimeter = createDelimeterString()
    }
    
    private func assembleViews() {
        dayTimeStack.addArrangedSubview(morningLabel)
        dayTimeStack.addArrangedSubview(dayLabel)
        dayTimeStack.addArrangedSubview(eveningLabel)
        dayTimeStack.addArrangedSubview(nightLabel)
        
        tempStack.addArrangedSubview(morningTempLabel)
        tempStack.addArrangedSubview(dayTempLabel)
        tempStack.addArrangedSubview(eveningTempLabel)
        tempStack.addArrangedSubview(nightTempLabel)
        
        feelStack.addArrangedSubview(morningFeelLabel)
        feelStack.addArrangedSubview(dayFeelLabel)
        feelStack.addArrangedSubview(eveningFeelLabel)
        feelStack.addArrangedSubview(nightFeelLabel)
        
        verticalStackView.addArrangedSubview(dateLabel)
        verticalStackView.addArrangedSubview(dayTimeStack)
        verticalStackView.addArrangedSubview(tempStack)
        verticalStackView.addArrangedSubview(feelsLikeLabel)
        verticalStackView.addArrangedSubview(feelStack)
        verticalStackView.addArrangedSubview(delimeter)
        
        addSubview(verticalStackView)
    }
    
    func setupLayout() {
        verticalStackView.turnOffMaskTranslation()
        verticalStackView.setTopAnchorEqualTo(safeAreaLayoutGuide.topAnchor, 10)
        verticalStackView.setLeadingAnchorEqualTo(safeAreaLayoutGuide.leadingAnchor)
        verticalStackView.setTrailingAnchorEqualTo(safeAreaLayoutGuide.trailingAnchor)
        
        dayTimeStack.turnOffMaskTranslation()
        dayTimeStack.setLeadingAnchorEqualTo(verticalStackView.leadingAnchor)
        dayTimeStack.setTrailingAnchorEqualTo(verticalStackView.trailingAnchor)
        
        tempStack.turnOffMaskTranslation()
        tempStack.setLeadingAnchorEqualTo(verticalStackView.leadingAnchor)
        tempStack.setTrailingAnchorEqualTo(verticalStackView.trailingAnchor)
        
        feelStack.turnOffMaskTranslation()
        feelStack.setLeadingAnchorEqualTo(verticalStackView.leadingAnchor)
        feelStack.setTrailingAnchorEqualTo(verticalStackView.trailingAnchor)
        
        delimeter.turnOffMaskTranslation()
        delimeter.setLeadingAnchorEqualTo(verticalStackView.leadingAnchor)
        delimeter.setTrailingAnchorEqualTo(verticalStackView.trailingAnchor)
        delimeter.setHeight(2)
    }
    
    func createVerticalStackView() -> UIStackView {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 30
        return sv
    }
    
    private func createLabel(text: String, color: UIColor = UIColor.blue, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = font
        label.textAlignment = .center
        return label
    }
    
    private func createHorizontalStackView() -> UIStackView {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }
    
    private func createDelimeterString() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }
}
