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
    
    // MARK: - State
    @ObservableState
    struct State {
        // Array of all questions fetched from the quiz service
        var quiz: [Question]?
        
        // Stack for managing navigation between quiz steps
        var stack = StackState<Path.State>()
        
        // Set of saved answer IDs, fetched from UserDefaults
        var savedAnswersIds: Set<String> = []
    }
    
    // MARK: - Actions
    enum Action {
        case loadQuiz                       // Trigger loading quiz from service
        case quizLoaded([Question]?)        // Action when quiz data is loaded
        case takeQuizTapped                 // User tapped "Take Quiz" button
        case getSavedUserAnswersIds         // Load previously selected answer IDs
        case stack(StackActionOf<Path>)     // Navigation stack actions
    }
    
    // MARK: - Dependencies
    @Dependency(\.quizService) var realQuizService
    @Dependency(\.userDefaultsManager) var userDefaultsManager
    
    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .loadQuiz:
                // MARK: Load quiz asynchronously
                return .run { send in
                    let quiz = await realQuizService.getUserQuiz()
                    await send(.quizLoaded(quiz))
                }
                
            case .quizLoaded(let qestions):
                // MARK: Save loaded quiz into state
                state.quiz = qestions
                return .none
                
            case .takeQuizTapped:
                // MARK: Push first quiz screen (Interests) onto the navigation stack
                guard let question = getNeedsQuestion(for: .interests, state: state) else {
                    return .none
                }
                state.stack.append(.userInterestsScreen(InterestsQuizStore.State(question: question)))
                return .none
                
            case .stack(.element(id: _, action: .userInterestsScreen(.continueQuiz))):
                // MARK: Push Styles screen after Interests is completed
                guard let question = getNeedsQuestion(for: .styles, state: state) else { return .none }
                state.stack.append(.userStylesScreen(InterestsQuizStore.State(question: question)))
                return .none
                
            case .stack(.element(id: _, action: .userStylesScreen(.continueQuiz))):
                // MARK: Push Colors screen after Styles is completed
                guard let question = getNeedsQuestion(for: .colors, state: state) else { return .none }
                state.stack.append(.userColorsScreen(InterestsQuizStore.State(question: question)))
                return .none
                
            case .getSavedUserAnswersIds:
                // MARK: Load saved IDs from UserDefaults
                state.savedAnswersIds = userDefaultsManager.getIds()
                return .none
                
            default:
                return .none
            }
        }
        // MARK: Handle each element in the navigation stack
        .forEach(\.stack, action: \.stack)
    }
    
    // MARK: - Helpers
    /// Returns the first question of the specified type from the quiz array
    private func getNeedsQuestion(for type: Question.QuestionType, state: State) -> Question? {
        state.quiz?.first(where: { $0.type == type })
    }
}

// MARK: - Navigation Path
extension GreetingsScreenStore {
    
    @Reducer
    enum Path {
        case userInterestsScreen(InterestsQuizStore)  // First quiz screen
        case userStylesScreen(InterestsQuizStore)     // Second quiz screen
        case userColorsScreen(InterestsQuizStore)     // Third quiz screen
    }
}
