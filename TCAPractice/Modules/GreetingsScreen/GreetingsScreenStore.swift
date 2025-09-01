//
//   GreetingsScreenReducer.swift
//  TCAPractice
//
//  Created by Rush_user on 29.08.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct GreetingsScreenStore {
    
    @ObservableState
    struct State {
        var quiz: Quiz?
        var stack = StackState<Path.State>()
    }
    
    enum Action {
        case loadQuiz
        case quizLoaded(Quiz?)
        case takeQuizTapped
        case stack(StackActionOf<Path>)
    }
    
    private let quizService: QuizServiceProtocol = MockQuizService()
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadQuiz:
                return .run { send in
                    let quiz = await quizService.getUserQuiz()
                    await send(.quizLoaded(quiz))
                }
            case .quizLoaded(let quiz):
                state.quiz = quiz
                return .none
                
            case .takeQuizTapped:
                state.stack.append(.userInterestsScreen(InterestsQuizStore.State(interests: state.quiz?.userInterests ?? [])))
                return .none
                
            case .stack:
                return .none
                
            }
        }
        .forEach(\.stack, action: \.stack)
    }
}

extension GreetingsScreenStore {
    
    @Reducer
    enum Path {
        case userInterestsScreen(InterestsQuizStore)
    }
}
