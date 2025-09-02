//
//  GreetingsView.swift
//  TCAPractice
//
//  Created by Rush_user on 28.08.2025.
//

import SwiftUI
import ComposableArchitecture

struct GreetingsView: View {
    
    // MARK: - Store
    @Perception.Bindable var store: StoreOf<GreetingsScreenStore>
    
    // MARK: - Body
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.stack, action: \.stack)) {
                
                // MARK: - Background
                ZStack {
                    Image(.threeWoman)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    GeometryReader { geo in
                        VStack {
                            Spacer()
                            
                            // MARK: - Gradient Overlay
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: geo.size.height * Constants.overlayRactangleHeightMultiplier)
                                .mask(
                                    LinearGradient(
                                        gradient: Constants.rectangleGradient,
                                        startPoint: .bottom,
                                        endPoint: .top
                                    )
                                )
                        }
                        .ignoresSafeArea()
                    }
                    
                    // MARK: - Foreground Content
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text(Constants.greetingText)
                                .foregroundStyle(.white)
                                .font(.system(size: Constants.greetingFontSize, weight: Constants.greetingFontWeight))
                            Spacer()
                        }
                        .padding(.horizontal, Constants.horizontalPadding)
                        
                        Spacer()
                            .frame(height: Constants.spacerHeightTop)
                        
                        // MARK: - Quiz Button
                        Button {
                            store.send(.takeQuizTapped)
                        } label: {
                            Text(Constants.quizButtonTitle)
                                .frame(width: Constants.quizButtonWidth, height: Constants.quizButtonHeight)
                                .background(Color.white)
                                .foregroundColor(.black)
                        }
                        .disabled(store.quiz?.isEmpty ?? true)
                        .contentShape(Rectangle())
                        
                        Spacer()
                            .frame(height: Constants.spacerHeightBottom)
                    }
                    .ignoresSafeArea()
                }
            }
            
            // MARK: - Navigation Destination
            destination: {
                switch $0.case {
                case .userInterestsScreen(let store):
                    InterestsView(store: store)
                        .navigationBarBackButtonHidden()
                case .userStylesScreen(let store), .userColorsScreen(let store):
                    InterestsView(store: store)
                }
            }
            
            // MARK: - Lifecycle
            .onAppear {
                store.send(.loadQuiz)
                store.send(.getSavedUserAnswersIds)
            }
            
            .accentColor(.black)
        }
    }
}

