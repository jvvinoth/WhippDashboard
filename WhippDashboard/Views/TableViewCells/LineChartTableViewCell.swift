//
//  LineChartTableViewCell.swift
//  WhippDashboard
//
//  Created by Vinoth Varatharajan on 30/12/2019.
//  Copyright © 2019 Vin. All rights reserved.
//

import UIKit
import Charts

enum LineChartType : String {
    case jobs
    case services
}

class LineChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        chartView.xAxis.labelTextColor = .clear
    }
    
    func setChartData(lineChartData : LineChart) {
        
        var jobs : [ChartDataEntry] = []
        var services : [ChartDataEntry] = []

        for x in 0...lineChartData.items.count-1 {
         
            for type in lineChartData.items[x].value {
             
                if let _type = LineChartType(rawValue: type.key) {
                    
                    switch _type {
                   
                    case .jobs: jobs.append(ChartDataEntry(x: Double(x), y: type.value))
                    case .services: services.append(ChartDataEntry(x: Double(x), y: type.value))
                    }
                }
            }
        }
        
        
        let set1 = LineChartDataSet(entries: jobs, label: "Jobs")
        
        set1.axisDependency = .left
        set1.setColor(UIColor.blue)
        set1.setCircleColor(.black)
        set1.lineWidth = 2
        set1.circleRadius = 3
       // set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let set2 = LineChartDataSet(entries: services, label: "Services")
        
        set2.axisDependency = .left
        set2.setColor(UIColor.red)
        set2.setCircleColor(.black)
        set2.lineWidth = 2
        set2.circleRadius = 3
        set2.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set2.drawCircleHoleEnabled = false
                
        let data = LineChartData(dataSets: [set1,set2])
        data.setValueTextColor(.black)
        data.setValueFont(.systemFont(ofSize: 9))
        
        chartView.data = data
    }
}
