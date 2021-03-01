//
//  RealmTableViewCell.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 19.02.2021.
//

import UIKit
import RealmSwift

class RealmTableViewCell: UITableViewCell {
    @IBOutlet weak var toDoLabel: UILabel!
    var tapCheck: (()-> Void)? = nil
    @IBAction func checkButton(_ sender: Any) {
        check.backgroundColor = .lightGray
        backgroundColor = .lightGray
        tapCheck?()
    }
    @IBOutlet weak var check: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
