//
//  UserInterestsEntity.swift
//  TCAPractice
//
//  Created by Rush_user on 28.08.2025.
//

import Foundation

struct Question: Equatable, Decodable {
    enum QuestionType: String, Decodable {
        case interests
        case styles
        case colors
    }

    let title: String
    let question: String
    let type: QuestionType
    let answers: [Answer]
}

struct Answer: Equatable, Decodable {
    let name: String
    let id: String
    let description: String?
    let imageUrl: String?
    let colorHex: String?
    
    init(name: String, id: String, description: String? = nil, imageUrl: String? = nil, colorHex: String? = nil) {
        self.name = name
        self.id = id
        self.description = description
        self.imageUrl = imageUrl
        self.colorHex = colorHex
    }
}
