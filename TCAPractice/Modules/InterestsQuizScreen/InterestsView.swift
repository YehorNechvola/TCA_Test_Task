//
//  QuizInterestsView.swift
//  TCAPractice
//
//  Created by Rush_user on 29.08.2025.
//

import SwiftUI
import ComposableArchitecture

struct InterestsView: View {
    
    @Perception.Bindable var store: StoreOf<InterestsQuizStore>
    
    var body: some View {
            VStack {
                Text(store.question.question)
                    .font(.system(size: 26, weight: .medium, design: .default))
                List(store.question.answers, id: \.id) { answer in
                    WithPerceptionTracking {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(answer.name)")
                                    .font(.system(size: 13, weight: .medium, design: .default))
                                Text("\(answer.description ?? "")")
                                    .font(.system(size: 14, weight: .light, design: .default))
                            }
                            
                            Spacer()
                            
                            ZStack {
                                Rectangle()
                                    .strokeBorder(Color.black, lineWidth: 1)
                                    .background(
                                        Rectangle()
                                            .fill(store.seletedInterestsIds.contains(answer.id) ? Color.black : Color.white)
                                    )
                                    .frame(width: 20, height: 20)
                                
                                if store.seletedInterestsIds.contains(answer.id) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12, weight: .medium))
                                }
                            }
                            .onTapGesture {
                                if store.seletedInterestsIds.contains(answer.id) {
                                    store.send(.deselectInterest(answer.id))
                                } else {
                                    store.send(.selectInterest(answer.id))
                                }
                            }
                        }
                        .frame(height: 72)
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, 16)
                        .overlay(Rectangle()
                            .stroke(Color.black, lineWidth: 1))
                    }
                }
                .listStyle(.plain)
                
                Button {
                    
                } label: {
                    Text("Continue")
                        .frame(width: 350, height: 48)
                        .background(Color.black)
                        .foregroundColor(.white)
                }
                .contentShape(Rectangle())
                
                Spacer()
            }
            .navigationTitle(store.question.title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
