//
//  MockQiuzService.swift
//  TCAPractice
//
//  Created by Rush_user on 28.08.2025.
//

import Foundation

protocol QuizServiceProtocol {
    func getUserQuiz() async -> Quiz?
}

final class MockQuizService: QuizServiceProtocol {
    
    //MARK: - Protocol Methods
    func getUserQuiz() async -> Quiz? {
        let userInterests: [UserInterestsEntity] = [
            .init(name: "Reinvent wardrobe",
                  description: "to discover fresh outfit ideas",
                  id: UUID().uuidString),
            .init(name: "Define color palette",
                  description: "to enhance my natural features",
                  id: UUID().uuidString),
            .init(name: "Create a seasonal capsule",
                  description: "to curate effortless and elegant looks",
                  id: UUID().uuidString),
            .init(name: "Define my style",
                  description: "to discover my signature look",
                  id: UUID().uuidString),
            .init(name: "Create an outfit for an event",
                  description: "to own a spotlight wherever you go",
                  id: UUID().uuidString)
        ]
        
        let userStylePreferences: [StylePreferencesEntity] = [
            .init(name: "casual", imageUrl: "casual", id: UUID().uuidString),
            .init(name: "boho", imageUrl: "boho", id: UUID().uuidString),
            .init(name: "classy", imageUrl: "classy", id: UUID().uuidString),
            .init(name: "ladylike", imageUrl: "ladylike", id: UUID().uuidString),
            .init(name: "urban", imageUrl: "urban", id: UUID().uuidString),
            .init(name: "sporty", imageUrl: "sporty", id: UUID().uuidString)
        ]
        
        let userLolorPreferences: [ColorPreferencesEntity] = [
            .init(name: "Light blue", hex: "#ABE2FF", id: UUID().uuidString),
            .init(name: "Blue", hex: "#5EA8FF", id: UUID().uuidString),
            .init(name: "Indigo", hex: "#2237A8", id: UUID().uuidString),
            .init(name: "Turquoise", hex: "#69D1ED", id: UUID().uuidString),
            .init(name: "Mint", hex: "#87DBC8", id: UUID().uuidString),
            .init(name: "Olive", hex: "#A8AD49", id: UUID().uuidString),
            .init(name: "Green", hex: "#29AD3E", id: UUID().uuidString),
            .init(name: "Emerald", hex: "#098052", id: UUID().uuidString),
            .init(name: "Yellow", hex: "#EDDD47", id: UUID().uuidString),
            .init(name: "Beige", hex: "#CA9675", id: UUID().uuidString),
            .init(name: "Orange", hex: "#CD6A09", id: UUID().uuidString),
            .init(name: "Brown", hex: "#7F4B03", id: UUID().uuidString),
            .init(name: "Pink", hex: "#FF86B8", id: UUID().uuidString),
            .init(name: "Magenta", hex: "#CF236E", id: UUID().uuidString),
            .init(name: "Red", hex: "#D31E1E", id: UUID().uuidString)
        ]
        
        let userQuiz = Quiz(userInterests: userInterests,
                            userStylePreferences: userStylePreferences,
                            userColorPreferences: userLolorPreferences)
        
        return userQuiz
    }
}
