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

struct UserInterestsEntity {
    let name: String
    let description: String
}

struct StylePreferencesEntity {
    let name: String
    let imageUrl: String
}

struct ColorPreferencesEntity {
    let name: String
    let hex: String
}
