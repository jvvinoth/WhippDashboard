//
//  DashboardViewController.swift
//  WhippDashboard
//
//  Created by Vinoth Varatharajan on 30/12/2019.
//  Copyright © 2019 Vin. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var mockTable: UITableView!
    @IBOutlet weak var appliedFilterLabel: UILabel!
    
    private var analaytics : Analytics!
    private var filters = ["ALL","TODAY","LAST 7 DAYS","LAST 30 DAYS"]
    private var selectedIndex = 0
    private var holdingIndex = 0

    lazy var viewmodel : DashboardViewModel = {
        return DashboardViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewmodel.delegate = self
        viewmodel.getMockData(scope: filters[selectedIndex])
        
        mockTable.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
        mockTable.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
        mockTable.register(UINib(nibName: "JobsTableViewCell", bundle: nil), forCellReuseIdentifier: "JobsTableViewCell")
        mockTable.register(UINib(nibName: "LineChartTableViewCell", bundle: nil), forCellReuseIdentifier: "LineChartTableViewCell")
        mockTable.register(UINib(nibName: "PieChartTableViewCell", bundle: nil), forCellReuseIdentifier: "PieChartTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    
    func showPickerInActionSheet() {
        
        let title = "Dashboard Filter"
        let message = "Dashboard data will get filtered based on this"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet);
        
        alert.isModalInPopover = true
        
        let pickerFrame: CGRect = CGRect(x: 17, y: 52, width: 270, height: 100)
        let picker: UIPickerView = UIPickerView(frame: pickerFrame)
        
        picker.delegate = self
        picker.dataSource = self
        
        alert.view.addSubview(picker)
        
        self.present(alert, animated: true, completion: nil);
    }
    
    @IBAction func filterAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Dashboard Filter", message: "Dashboard data will get filter based on this", preferredStyle: .actionSheet)
        
        alert.addPickerView(values: [filters] ,initialSelection: (column: 0, row: selectedIndex)) { vc, picker, index, values in
            
            self.holdingIndex = index.row
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    vc.preferredContentSize.height = 200
                }
            }
        }
        
        alert.addAction(image: nil, title: "Cancel", color: nil, style: .cancel, isEnabled: true, handler: { action in
            
        })
        
        alert.addAction(image: nil, title: "Apply", color: nil, style: .default, isEnabled: true, handler: { action in
            self.selectedIndex = self.holdingIndex
            self.viewmodel.getMockData(scope: self.filters[self.selectedIndex])
            self.appliedFilterLabel.text = self.filters[self.selectedIndex]
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension DashboardViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filters[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}

extension DashboardViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return analaytics != nil ? 5 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 : guard let _ = analaytics.rating else { return 0 } ; return 1
        case 1 : guard let job = analaytics.job else { return 0 } ; return job.items.count
        case 2 : guard let service = analaytics.service else { return 0 } ; return service.items.count
        case 3 : guard let lineChart = analaytics.lineCharts else { return 0 } ; return lineChart[0].count
        case 4 : guard let pieChart = analaytics.pieCharts else { return 0 } ; return pieChart.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let ratingcell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
            
            ratingcell.averageRatingLabel.text = String(format: "%.1f", Float(analaytics.rating!.avg))
            
            let ratings = analaytics.rating!.items
            
            for item in ratingcell.ratingProgressCollection {
                
                if let value = ratings["\(item.tag)"], let maxValue = ratings.values.max() {
                    item.progress = Float(Float(value)/Float(maxValue))
                }
                else {
                    item.progress = 0
                }
            }
            
            ratingcell.totalRatingsCountLabel.text = "\(ratings.values.reduce(0, +)) Ratings"
            
            return ratingcell
            
        case 1:
            
            let jobscell = tableView.dequeueReusableCell(withIdentifier: "JobsTableViewCell", for: indexPath) as! JobsTableViewCell
            
            jobscell.titleLabel.text = analaytics.job!.items[indexPath.row].title
            jobscell.descriptionLabel.text = analaytics.job!.items[indexPath.row].itemDescription
            jobscell.percentageLabel.text = "\(analaytics.job!.items[indexPath.row].growth)%"
            
            jobscell.downImage.isHidden = analaytics.job!.items[indexPath.row].growth >= 0
            jobscell.upImage.isHidden = !jobscell.downImage.isHidden
            
            return jobscell
            
        case 2:
            
            let jobscell = tableView.dequeueReusableCell(withIdentifier: "JobsTableViewCell", for: indexPath) as! JobsTableViewCell
            
            jobscell.titleLabel.text = analaytics.service!.items[indexPath.row].title
            jobscell.descriptionLabel.text = analaytics.service!.items[indexPath.row].itemDescription
            jobscell.percentageLabel.text = "\(analaytics.service!.items[indexPath.row].growth)%"
            
            jobscell.downImage.isHidden = analaytics.service!.items[indexPath.row].growth >= 0
            jobscell.upImage.isHidden = !jobscell.downImage.isHidden
            
            return jobscell
            
        case 3:
            
            let lineChartCell = tableView.dequeueReusableCell(withIdentifier: "LineChartTableViewCell", for: indexPath) as! LineChartTableViewCell
            
            lineChartCell.titleLabel.text = analaytics.lineCharts![0][indexPath.row].title
            lineChartCell.descriptionLabel.text = analaytics.lineCharts![0][indexPath.row].lineChartDescription
            lineChartCell.setChartData(lineChartData: analaytics.lineCharts![0][indexPath.row])
            
            return lineChartCell
            
        case 4:
            
            let pieChartCell = tableView.dequeueReusableCell(withIdentifier: "PieChartTableViewCell", for: indexPath) as! PieChartTableViewCell
            
            pieChartCell.titlelabel.text = analaytics.pieCharts![indexPath.row].title
            pieChartCell.descriptionLabel.text = analaytics.pieCharts![indexPath.row].pieChartDescription
            pieChartCell.setChartData(chart: analaytics.pieCharts![indexPath.row])
            
            return pieChartCell
            
        default: return UITableViewCell()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        
        switch section {
        case 0:
            headerView.titleLabel.text = analaytics.rating?.title
            headerView.decscriptionlabel.text = analaytics.rating?.ratingDescription
            
        case 1:
            headerView.titleLabel.text = analaytics.job?.title
            headerView.decscriptionlabel.text = analaytics.job?.jobDescription
            
        case 2:
            headerView.titleLabel.text = analaytics.service?.title
            headerView.decscriptionlabel.text = analaytics.service?.jobDescription
            
        default: break
        }
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section > 2 {
            return 0
        }
        return 67
    }
}

extension DashboardViewController : DashboardViewModelDelegate {
    
    func getResponseSuccessfull(_ analytics: Analytics) {
        self.analaytics = analytics
        mockTable.reloadData()
    }
    
    func getResponseFailure() {
        
    }
}

extension UIAlertController {
    
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
    func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertAction.Style = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) {
        //let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
        //let action = UIAlertAction(title: title, style: isPad && style == .cancel ? .default : style, handler: handler)
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        
        // button image
        if let image = image {
            action.setValue(image, forKey: "image")
        }
        
        // button title color
        if let color = color {
            action.setValue(color, forKey: "titleTextColor")
        }
        
        addAction(action)
    }
}
