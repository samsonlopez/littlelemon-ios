//
//  UserSettings.swift
//  Restaurant
//
//  Created by Samson Lopez on 06/05/2023.
//

import Foundation

class UserSettings {
    static let shared = UserSettings()
    
    private let defaults = UserDefaults.standard
    
    let kFirstName = "FirstNameKey"
    let kLastName = "LastNameKey"
    let kEmail = "EmailKey"
    let kIsLoggedIn = "IsLoggedInKey"
    
    var firstName: String {
        get {
            return defaults.string(forKey: kFirstName) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: kFirstName)
        }
    }
    
    var lastName: String {
        get {
            return defaults.string(forKey: kLastName) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: kLastName)
        }
    }
    
    var email: String {
        get {
            return defaults.string(forKey: kEmail) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: kEmail)
        }
    }
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: kIsLoggedIn)
        }
        set(value) {
            defaults.set(value, forKey: kIsLoggedIn)
        }
    }
    
    func clear() {
        defaults.removeObject(forKey: kFirstName)
        defaults.removeObject(forKey: kLastName)
        defaults.removeObject(forKey: kEmail)
        defaults.removeObject(forKey: kIsLoggedIn)
    }
}
