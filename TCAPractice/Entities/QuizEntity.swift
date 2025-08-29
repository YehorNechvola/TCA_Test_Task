//
//  UserInterestsEntity.swift
//  TCAPractice
//
//  Created by Rush_user on 28.08.2025.
//

import Foundation

struct Quiz {
    let userInterests: [UserInterestsEntity]
    let userStylePreferences: [StylePreferencesEntity]
    let userColorPreferences: [ColorPreferencesEntity]
}

struct UserInterestsEntity: Identifiable {
    let name: String
    let description: String
    let id: String
}

struct StylePreferencesEntity: Identifiable {
    let name: String
    let imageUrl: String
    let id: String
}

struct ColorPreferencesEntity: Identifiable {
    let name: String
    let hex: String
    let id: String 
}
