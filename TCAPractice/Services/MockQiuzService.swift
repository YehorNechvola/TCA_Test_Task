//
//  MockQiuzService.swift
//  TCAPractice
//
//  Created by Rush_user on 28.08.2025.
//

import Foundation

protocol QuizServiceProtocol {
    func getUserQuiz() async -> [Question]?
}

final class MockQuizService: QuizServiceProtocol {
    
    //MARK: - Protocol Methods
    func getUserQuiz() async -> [Question]? {
        let userInterestsAnswers: [Answer] = [
            .init(name: "Reinvent wardrobe",
                  id: "1",
                  description: "to discover fresh outfit ideas"),
            .init(name: "Define color palette",
                  id: "2",
                  description: "to enhance my natural features")
                  ,
            .init(name: "Create a seasonal capsule",
                  id: "3",
                  description: "to curate effortless and elegant looks"),
            .init(name: "Define my style",
                  id: "4",
                  description: "to discover my signature look"),
            .init(name: "Create an outfit for an event",
                  id: "5",
                  description: "to own a spotlight wherever you go"),
        ]
        
        let userStylePreferences: [Answer] = [
            .init(name: "casual", id: "6", imageUrl: "casual"),
            .init(name: "boho", id: "7", imageUrl: "boho"),
            .init(name: "classy", id: "8", imageUrl: "classy"),
            .init(name: "ladylike", id: "9", imageUrl: "ladylike"),
            .init(name: "urban", id: "10", imageUrl: "urban"),
            .init(name: "sporty", id: "11", imageUrl: "sporty")
        ]
        
        let userLolorPreferences: [Answer] = [
            .init(name: "Light blue", id: "12", colorHex: "#ABE2FF"),
            .init(name: "Blue", id: "13", colorHex: "#5EA8FF"),
            .init(name: "Indigo", id: "14", colorHex: "#2237A8"),
            .init(name: "Turquoise", id: "15", colorHex: "#69D1ED"),
            .init(name: "Mint", id: "16", colorHex: "#87DBC8"),
            .init(name: "Olive", id: "17", colorHex: "#A8AD49"),
            .init(name: "Green", id: "18", colorHex: "#29AD3E"),
            .init(name: "Emerald", id: "19", colorHex: "#098052"),
            .init(name: "Yellow", id: "20", colorHex: "#EDDD47"),
            .init(name: "Beige", id: "21", colorHex: "#CA9675"),
            .init(name: "Orange", id: "22", colorHex: "#CD6A09"),
            .init(name: "Brown", id: "23", colorHex: "#7F4B03"),
            .init(name: "Pink", id: "24", colorHex: "#FF86B8"),
            .init(name: "Magenta", id: "25", colorHex: "#CF236E"),
            .init(name: "Red", id: "26", colorHex: "#D31E1E")
        ]
        
        let questions: [Question] = [
            .init(title: "Lifestyle & Interests",
                  question: "What’d you like our stylists to focus on?",
                  type: .interests,
                  answers: userInterestsAnswers),
            .init(title: "Style preferences",
                  question: "What’d you like our stylists to focus on?",
                  type: .styles,
                  answers: userStylePreferences),
            .init(title: "Color preferences",
                  question: "Choose favourite colors",
                  type: .colors,
                  answers: userLolorPreferences)
        ]
        
        return questions
    }
}
