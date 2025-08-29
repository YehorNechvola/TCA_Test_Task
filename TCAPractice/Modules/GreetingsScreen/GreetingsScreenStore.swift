//
//   GreetingsScreenReducer.swift
//  TCAPractice
//
//  Created by Rush_user on 29.08.2025.
//

import Foundation
import ComposableArchitecture

struct GreetingsScreenStore: Reducer {
    
    struct State: Equatable {
        var quiz: Quiz?
    }
    
    enum Action {
        case loadQuiz
        case quizLoaded(Quiz?)
        case takeQuizTapped
    }
    
    private let quizService: QuizServiceProtocol = MockQuizService()
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .loadQuiz:
            return .run { send in
                if let quiz = await quizService.getUserQuiz() {
                    await send(.quizLoaded(quiz))
                } else {
                    await send(.quizLoaded(nil))
                }
            }
        case .quizLoaded(let quiz):
            state.quiz = quiz
            return .none
        case .takeQuizTapped:
            return .none
        }
    }
}
