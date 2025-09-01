//
//  QuizInterestsView.swift
//  TCAPractice
//
//  Created by Rush_user on 29.08.2025.
//

import SwiftUI
import ComposableArchitecture

struct QuizInterestsView: View {
    
    @Perception.Bindable var store: StoreOf<InterestsQuizStore>
    
    var body: some View {
        WithPerceptionTracking {
            Text("\(store.interests.first?.name ?? "No interests")")
        }
    }
}
