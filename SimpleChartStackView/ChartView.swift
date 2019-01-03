//
//  ChartView.swift
//  SimpleChartStackView
//
//  Created by Javier Loucim on 02/01/2019.
//  Copyright © 2019 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

struct ChartItem {
    var value: Double
    var color: UIColor
    var topTitle: String
    var bottomTitle: String
}

struct ChartData {
    var values: [ChartItem] = [ChartItem]() {
        didSet {
            guard !values.isEmpty else {
                maxValue = 0
                return
            }
            maxValue = 0
            for item in values {
                if item.value > maxValue! {
                    maxValue = item.value
                }
            }
        }
    }
    var maxValue: Double?
}

class ChartView: UIView {
    static let labelsHeight: CGFloat = 30
    static let spacing: CGFloat = 8
    func configure(with chartData: ChartData, estimatedHeight: CGFloat? = nil) {
        guard chartData.maxValue != nil else { return }
        
        let labelsHeight: CGFloat = ChartView.labelsHeight
        let maxHeightForBar = (estimatedHeight ?? self.bounds.height) - (2 * labelsHeight) - (3 * ChartView.spacing)
        let chartStackView = UIStackView()
        chartStackView.frame = self.bounds
        chartStackView.axis = .horizontal
        chartStackView.spacing = 0
        chartStackView.alignment = .fill
        chartStackView.distribution = .fillEqually
        chartStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        for item in chartData.values {
            let height: CGFloat = maxHeightForBar * CGFloat(item.value/chartData.maxValue!)
            let view = createStackViewForChart(height: height, topLabel: item.topTitle, bottomLabel: item.bottomTitle, color: item.color)
            chartStackView.addArrangedSubview(view)
        }
        self.addSubview(chartStackView)
        
    }
    fileprivate func createStackViewForChart(height: CGFloat, topLabel: String, bottomLabel:String, color: UIColor) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = ChartView.spacing
        
        let topGraphLabel = UILabel()
        topGraphLabel.text = topLabel
        topGraphLabel.textAlignment = .center
        topGraphLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        topGraphLabel.sizeToFit()
        topGraphLabel.adjustsFontSizeToFitWidth = true
        topGraphLabel.textColor = .black
        topGraphLabel.heightAnchor.constraint(equalToConstant:  ChartView.labelsHeight).isActive = true
        
        let graphLabel = UILabel()
        graphLabel.text = bottomLabel
        graphLabel.textAlignment = .center
        graphLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        graphLabel.sizeToFit()
        graphLabel.adjustsFontSizeToFitWidth = true
        graphLabel.textColor = .black
        graphLabel.heightAnchor.constraint(equalToConstant:  ChartView.labelsHeight).isActive = true
        
        let view = UIView()
        view.backgroundColor = color
        view.heightAnchor.constraint(equalToConstant:  height).isActive = true
        
        let spacerView = UIView()
        
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(topGraphLabel)
        stackView.addArrangedSubview(view)
        stackView.addArrangedSubview(graphLabel)
        return stackView
    }
}
