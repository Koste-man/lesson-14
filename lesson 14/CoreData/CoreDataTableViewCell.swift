//
//  CoreDataTableViewCell.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 26.02.2021.
//

import UIKit

class CoreDataTableViewCell: UITableViewCell {
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkButtonAction(_ sender: Any) {
        checkButton.backgroundColor = .lightGray
        backgroundColor = .lightGray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
