//
//  SwitchinQuizService.swift
//  TCAPractice
//
//  Created by Rush_user on 03.09.2025.
//

import Foundation

final class SwitchingQuizService: QuizServiceProtocol {
    
    // MARK: - Properties
    var real: QuizServiceProtocol
    var mock: QuizServiceProtocol
    var shouldUseMock: Bool
    
    init(real: QuizServiceProtocol, mock: QuizServiceProtocol, shouldUseMock: Bool) {
        self.real = real
        self.mock = mock
        self.shouldUseMock = shouldUseMock
    }

    // MARK: - Protocol Method
    func getUserQuiz() async -> [Question]? {
        if shouldUseMock {
            return await mock.getUserQuiz()
        } else {
            return await real.getUserQuiz()
        }
    }
}
