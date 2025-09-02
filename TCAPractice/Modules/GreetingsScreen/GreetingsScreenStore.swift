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
        var qestions: [Question]?
        var stack = StackState<Path.State>()
        var savedAnswersIds: Set<String> = []
    }
    
    enum Action {
        case loadQuiz
        case quizLoaded([Question]?)
        case takeQuizTapped
        case getSavedUserAnswersIds
        case stack(StackActionOf<Path>)
    }
    
    private let quizService: QuizServiceProtocol = MockQuizService()
    private let userDefaultsManager = UserDefaultsManager.shared
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadQuiz:
                return .run { send in
                    let quiz = await quizService.getUserQuiz()
                    await send(.quizLoaded(quiz))
                }
            case .quizLoaded(let qestions):
                state.qestions = qestions
                return .none
                
            case .takeQuizTapped:
                guard let question = state.qestions?.first else {
                    return .none
                }
                state.stack.append(.userInterestsScreen(InterestsQuizStore.State(question: question,
                                                                                 seletedInterestsIds: state.savedAnswersIds)))
                return .none
                
            case .stack(.element(id: _, action: .userInterestsScreen(.continueQuiz))):
                guard let questions = state.qestions else { return .none }
                let q2 = questions[1]
                state.stack.append(.userStylesScreen(InterestsQuizStore.State(question: q2,
                                                                              seletedInterestsIds: state.savedAnswersIds)))
                return .none
                
            case .stack(.element(id: _, action: .userStylesScreen(.continueQuiz))):
                guard let questions = state.qestions else { return .none }
                let q2 = questions[2]
                state.stack.append(.userColorsScreen(InterestsQuizStore.State(question: q2,
                                                                              seletedInterestsIds: state.savedAnswersIds)))
                return .none
        
            case .getSavedUserAnswersIds:
                state.savedAnswersIds = userDefaultsManager.getIds()
                return .none
                
            default:
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
        case userStylesScreen(InterestsQuizStore)
        case userColorsScreen(InterestsQuizStore)
    }
}
