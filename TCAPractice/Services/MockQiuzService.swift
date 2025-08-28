//
//  MockQiuzService.swift
//  TCAPractice
//
//  Created by Rush_user on 28.08.2025.
//

import Foundation

protocol QuizServiceProtocol {
    func getUserQuiz() -> Quiz
}

final class MockQuizService: QuizServiceProtocol {
    
    //MARK: - Protocol Methods
    func getUserQuiz() -> Quiz {
        let userInterests: [UserInterestsEntity] = [
            .init(name: "Reinvent wardrobe", description: "to discover fresh outfit ideas"),
            .init(name: "Define color palette", description: "to enhance my natural features"),
            .init(name: "Create a seasonal capsule", description: "to curate effortless and elegant looks"),
            .init(name: "Define my style", description: "to discover my signature look"),
            .init(name: "Create an outfit for an event", description: "to own a spotlight wherever you go")
        ]
        
        let userStylePreferences: [StylePreferencesEntity] = [
            .init(name: "casual", imageUrl: "casual"),
            .init(name: "boho", imageUrl: "boho"),
            .init(name: "classy", imageUrl: "classy"),
            .init(name: "ladylike", imageUrl: "ladylike"),
            .init(name: "urban", imageUrl: "urban"),
            .init(name: "sporty", imageUrl: "sporty")
        ]
        
        let userLolorPreferences: [ColorPreferencesEntity] = [
            .init(name: "Light blue", hex: "#ABE2FF"),
            .init(name: "Blue", hex: "#5EA8FF"),
            .init(name: "Indigo", hex: "#2237A8"),
            .init(name: "Turquoise", hex: "#69D1ED"),
            .init(name: "Mint", hex: "#87DBC8"),
            .init(name: "Olive", hex: "#A8AD49"),
            .init(name: "Green", hex: "#29AD3E"),
            .init(name: "Emerald", hex: "#098052"),
            .init(name: "Yellow", hex: "#EDDD47"),
            .init(name: "Beige", hex: "#CA9675"),
            .init(name: "Orange", hex: "#CD6A09"),
            .init(name: "Brown", hex: "#7F4B03"),
            .init(name: "Pink", hex: "#FF86B8"),
            .init(name: "Magenta", hex: "#CF236E"),
            .init(name: "Red", hex: "#D31E1E")
        ]
        
        let userQuiz = Quiz(userInterests: userInterests,
                            userStylePreferences: userStylePreferences,
                            userColorPreferences: userLolorPreferences)
        
        return userQuiz
    }
}
