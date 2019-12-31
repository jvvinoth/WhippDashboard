//
//  RatingTableViewCell.swift
//  WhippDashboard
//
//  Created by Vinoth Varatharajan on 30/12/2019.
//  Copyright © 2019 Vin. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var totalRatingsCountLabel: UILabel!
    @IBOutlet var ratingProgressCollection: [UIProgressView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
