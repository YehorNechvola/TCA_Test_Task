//
//  Dependencies.swift
//  TCAPractice
//
//  Created by Rush_user on 02.09.2025.
//

import ComposableArchitecture

private enum QuizServiceKey: DependencyKey {
    static let liveValue: QuizServiceProtocol = MockQuizService()
}

extension DependencyValues {
    var quizService: QuizServiceProtocol {
        get { self[QuizServiceKey.self] }
        set { self[QuizServiceKey.self] = newValue }
    }
}

private enum UserDefaultsManagerKey: DependencyKey {
    static let liveValue: UserDefaultsManager = .shared
}

extension DependencyValues {
    var userDefaultsManager: UserDefaultsManager {
        get { self[UserDefaultsManagerKey.self] }
        set { self[UserDefaultsManagerKey.self] = newValue }
    }
}

