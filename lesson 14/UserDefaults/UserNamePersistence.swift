//
//  UserNamePersistence.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 19.02.2021.
//

import Foundation

class UserNamePersistance{
    static let storage = UserNamePersistance()
    
    private let firstNameKey = "UserNamePersistance.firstNameKey"
    var firstName: String?{
        set {UserDefaults.standard.set(newValue, forKey: firstNameKey)}
        get {return UserDefaults.standard.string(forKey: firstNameKey)}
    }
    
    private let lastNameKey = "UserNamePersistance.lastNameKey"
    var lastName: String?{
        set {UserDefaults.standard.set(newValue, forKey: lastNameKey)}
        get {return UserDefaults.standard.string(forKey: lastNameKey)}
    }
}
