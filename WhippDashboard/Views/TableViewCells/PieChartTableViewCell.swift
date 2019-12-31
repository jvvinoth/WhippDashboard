//
//  PieChartTableViewCell.swift
//  WhippDashboard
//
//  Created by Vinoth Varatharajan on 30/12/2019.
//  Copyright © 2019 Vin. All rights reserved.
//

import UIKit
import Charts

class PieChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var chartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        chartView.transparentCircleRadiusPercent = 0.5
        chartView.holeRadiusPercent = 0.2
    }
    
    func setChartData( chart : PieChart ) {
        
        var entries : [PieChartDataEntry] = []
        
        for item in chart.items {
            entries.append(PieChartDataEntry(value: item.value, label: item.key))
        }
        
        let set = PieChartDataSet(entries: entries)
        set.sliceSpace = CGFloat(entries.count)
        
        set.colors = [UIColor(red: 240/255, green: 195/255, blue: 48/255, alpha: 1)] + [UIColor(red: 56/255, green: 203/255, blue: 115/255, alpha: 1)] + ChartColorTemplates.colorful()
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        
        chartView.data = data
        chartView.highlightValues(nil)
    }
}
