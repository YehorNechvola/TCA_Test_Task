//
//  UserDefaultsManager.swift
//  TCAPractice
//
//  Created by Rush_user on 01.09.2025.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let key = "savedIds"
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    func getIds() -> Set<String> {
        let array = defaults.stringArray(forKey: key) ?? []
        return Set(array)
    }
    
    func addId(_ id: String) {
        var ids = getIds()
        ids.insert(id)
        defaults.set(Array(ids), forKey: key)
    }
    
    func removeId(_ id: String) {
        var ids = getIds()
        ids.remove(id)
        defaults.set(Array(ids), forKey: key)
    }
    
    func clear() {
        defaults.removeObject(forKey: key)
    }
}
