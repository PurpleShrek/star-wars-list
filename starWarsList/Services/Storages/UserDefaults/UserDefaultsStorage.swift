//
//  UserDefaultsStorage.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 15/12/2022.
//

import Foundation

struct DefaultsData {
    //MARK: - Enum
    enum UserDefaultsManager: String {
        case screenNumber //screen number on which app closed (main - 0, world - 1, person - 2)
    }
    
    //MARK: - Set method
    public func set(value: Any?, key: UserDefaultsManager) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    //MARK: - Get methods
//    public func fetchBool(_ key: UserDefaultsManager) -> Bool {
//        return UserDefaults.standard.bool(forKey: key.rawValue)
//    }
//
//    public func fetchString(_ key: UserDefaultsManager) -> String {
//        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
//    }
    
    public func fetchInt(_ key: UserDefaultsManager) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
//    public func fetchDouble(_ key: UserDefaultsManager) -> Double {
//        return UserDefaults.standard.double(forKey: key.rawValue)
//    }
}
