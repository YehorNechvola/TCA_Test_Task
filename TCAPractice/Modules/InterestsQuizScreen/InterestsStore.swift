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
        var seletedInterestsIds: Set<String>
    }
    
    enum Action: Equatable {
        case selectInterest(String)
        case deselectInterest(String)
        case continueQuiz
    }
    
    private let userDefaultsManeger = UserDefaultsManager.shared
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .selectInterest(let id):
            userDefaultsManeger.addId(id)
            state.seletedInterestsIds.insert(id)
            return .none
        case .deselectInterest(let id):
            userDefaultsManeger.removeId(id)
            state.seletedInterestsIds.remove(id)
            return .none
        case .continueQuiz:
            return .none
        }
    }
}
