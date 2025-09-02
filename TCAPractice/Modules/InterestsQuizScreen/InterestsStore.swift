//
//  InterestsQuizStore.swift
//  TCAPractice
//
//  Created by Rush_user on 29.08.2025.
//

import Foundation
import ComposableArchitecture

struct InterestsQuizStore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        let question:  Question
        var seletedInterestsIds: Set<String> = []
    }
    
    enum Action: Equatable {
        case getSavedAnswersId
        case selectInterest(String)
        case deselectInterest(String)
        case continueQuiz
    }
    
    @Dependency(\.userDefaultsManager) var userDefaultsManager
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .getSavedAnswersId:
            state.seletedInterestsIds = userDefaultsManager.getIds()
            return .none
        case .selectInterest(let id):
            userDefaultsManager.addId(id)
            state.seletedInterestsIds.insert(id)
            return .none
        case .deselectInterest(let id):
            userDefaultsManager.removeId(id)
            state.seletedInterestsIds.remove(id)
            return .none
        case .continueQuiz:
            return .none
        }
    }
}
