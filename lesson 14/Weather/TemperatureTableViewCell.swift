//
//  TemperatureTableViewCell.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 01.03.2021.
//

import UIKit

class TemperatureTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
