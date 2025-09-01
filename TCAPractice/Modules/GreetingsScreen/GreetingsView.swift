//
//  GreetingsView.swift
//  TCAPractice
//
//  Created by Rush_user on 28.08.2025.
//

import SwiftUI
import ComposableArchitecture

struct GreetingsView: View {
    
    private enum Constants {
        static let overlayRactangleHeightMultiplier: CGFloat = 0.7
        static let rectangleGradient = Gradient(stops: [
            .init(color: .black, location: 0.0),
            .init(color: .black, location: 0.4),
            .init(color: .clear, location: 1.0)
        ])
        static let greetingText = "Online Personal\nStyling.\nOutfits for\nEvery Woman."
        static let quizButtonTitle = "TAKE A QUIZ"
    }
    
    @Perception.Bindable var store: StoreOf<GreetingsScreenStore>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.stack, action: \.stack)) {
                ZStack {
                    Image(.threeWoman)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    GeometryReader { geo in
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: geo.size.height * Constants.overlayRactangleHeightMultiplier)
                                .mask(
                                    LinearGradient(
                                        gradient: Constants.rectangleGradient,
                                        startPoint: .bottom,
                                        endPoint: .top))
                        }
                        .ignoresSafeArea()
                    }
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text(Constants.greetingText)
                                .foregroundStyle(.white)
                                .font(.system(size: 32, weight: .medium, design: .default))
                            Spacer()
                        }
                        .padding(.horizontal, 40)
                        
                        Spacer()
                            .frame(height: 80)
                        
                        Button {
                            store.send(.takeQuizTapped)
                        } label: {
                            Text(Constants.quizButtonTitle)
                                .frame(width: 350, height: 48)
                                .background(Color.white)
                                .foregroundColor(.black)
                        }
                        .disabled(store.qestions?.isEmpty ?? true)
                        .contentShape(Rectangle())
                        
                        Spacer()
                            .frame(height: 62)
                    }
                    .ignoresSafeArea()
                }
            } destination: {
                switch $0.case {
                case .userInterestsScreen(let store):
                    InterestsView(store: store)
                        .navigationBarBackButtonHidden()
                }
            }
            .onAppear {
                store.send(.loadQuiz)
                store.send(.getSavedUserAnswersIds)
            }
        }
    }
}

