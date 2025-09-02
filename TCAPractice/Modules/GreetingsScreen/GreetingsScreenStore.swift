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
        var quiz: [Question]?
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
    
    @Dependency(\.quizService) var realQuizService
    @Dependency(\.userDefaultsManager) var userDefaultsManager
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadQuiz:
                return .run { send in
                    let quiz = await realQuizService.getUserQuiz()
                    await send(.quizLoaded(quiz))
                }
            case .quizLoaded(let qestions):
                state.quiz = qestions
                return .none
                
            case .takeQuizTapped:
                guard let question = getNeedsQuestion(for: .interests, state: state) else {
                    return .none
                }
                state.stack.append(.userInterestsScreen(InterestsQuizStore.State(question: question,
                                                                                 seletedInterestsIds: state.savedAnswersIds)))
                return .none
                
            case .stack(.element(id: _, action: .userInterestsScreen(.continueQuiz))):
                guard let question = getNeedsQuestion(for: .styles, state: state) else { return .none }
                state.stack.append(.userStylesScreen(InterestsQuizStore.State(question: question,
                                                                              seletedInterestsIds: state.savedAnswersIds)))
                return .none
                
            case .stack(.element(id: _, action: .userStylesScreen(.continueQuiz))):
                guard let question = getNeedsQuestion(for: .colors, state: state) else { return .none }
                state.stack.append(.userColorsScreen(InterestsQuizStore.State(question: question,
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
    
    private func getNeedsQuestion(for type: Question.QuestionType, state: State) -> Question? {
        state.quiz?.first(where: { $0.type == type })
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
