//
//  InterestsQuizStore.swift
//  TCAPractice
//
//  Created by Rush_user on 29.08.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct InterestsQuizStore {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        // Current quiz question being displayed
        let question: Question
        
        // Set of selected answer IDs for this question
        var seletedInterestsIds: Set<String> = []
    }
    
    // MARK: - Actions
    enum Action: Equatable {
        case getSavedAnswersId           // Load previously selected answers from UserDefaults
        case selectInterest(String)      // User selects an answer
        case deselectInterest(String)    // User deselects an answer
        case continueQuiz                // Continue to next quiz step
    }
    
    // MARK: - Dependencies
    @Dependency(\.userDefaultsManager) var userDefaultsManager
    
    // MARK: - Reducer
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .getSavedAnswersId:
            // MARK: Load saved IDs from UserDefaults into the state
            state.seletedInterestsIds = userDefaultsManager.getIds()
            return .none
            
        case .selectInterest(let id):
            // MARK: Add selected answer ID to UserDefaults and state
            userDefaultsManager.addId(id)
            state.seletedInterestsIds.insert(id)
            return .none
            
        case .deselectInterest(let id):
            // MARK: Remove deselected answer ID from UserDefaults and state
            userDefaultsManager.removeId(id)
            state.seletedInterestsIds.remove(id)
            return .none
            
        case .continueQuiz:
            // MARK: Action placeholder for continuing the quiz
            return .none
        }
    }
}
