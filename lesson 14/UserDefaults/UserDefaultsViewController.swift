//
//  UserDefaultsViewController.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 19.02.2021.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBAction func firstNameChanged(_ sender: Any) {
        UserNamePersistance.storage.firstName = firstNameTextField.text
    }
    @IBAction func lastNameChanged(_ sender: Any) {
        UserNamePersistance.storage.lastName = lastNameTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.text = UserNamePersistance.storage.firstName
        lastNameTextField.text = UserNamePersistance.storage.lastName
    }
}
