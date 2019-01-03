//
//  ChartViewController.swift
//  SimpleChartStackView
//
//  Created by Javier Loucim on 02/01/2019.
//  Copyright © 2019 Javier Loucim. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    @IBOutlet weak var chartView: ChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var chartData = ChartData()
        for x in 1...24 {
            chartData.values.append(ChartItem(value: Double(x), color: x % 2 == 0 ? .gray : .lightGray, topTitle: x == 1 || x == 5 ? "top\(x)" : " ", bottomTitle: x == 1 || x == 5 ? "$\(x)" : " "))
        }
        chartView.configure(with: chartData)
    }

}
