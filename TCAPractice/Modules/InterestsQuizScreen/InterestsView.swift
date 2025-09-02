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
                
                switch store.question.type {
                case .interests:
                    createList()
                case .styles:
                    createCollection(columns: 2)
                case .colors:
                    createCollection(columns: 3)
                }
                
                Button {
                    store.send(.continueQuiz)
                } label: {
                    Text("Continue")
                        .frame(width: 350, height: 48)
                        .background(Color.black)
                        .foregroundColor(.white)
                }
                .contentShape(Rectangle())
                
                Spacer()
            }
            .navigationBarTitle(store.question.title, displayMode: .inline)
    }
}

private extension InterestsView {
    
    @ViewBuilder
    private func createList() -> some View {
        List(store.question.answers, id: \.id) { answer in
            WithPerceptionTracking {
                createListRow(answer: answer)
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    private func createListRow(answer: Answer) -> some View {
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
    
    @ViewBuilder
    private func createCollection(columns: Int) -> some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: columns)
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(store.question.answers, id: \.id) { answer in
                    WithPerceptionTracking {
                        createCollectionCell(answer: answer)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
    
    @ViewBuilder
    func createCollectionCell(answer: Answer) -> some View {
        ZStack {
            VStack {
                if let imageUrl = answer.imageUrl {
                    let url = Bundle.main.url(forResource: imageUrl, withExtension: "png")
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        default:
                            EmptyView()
                        }
                    }
                } else {
                    Rectangle()
                        .fill(Color(hex: answer.colorHex ?? ""))
                        .frame(width: 32, height: 32)
                        
                }
                
                Text(answer.name.uppercased())
                    .font(.system(size: 13, weight: .light))
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    createCheckmarkButton(itemId: answer.id)
                }
                Spacer()
            }
        }
        .padding(8)
        .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
        .aspectRatio(1, contentMode: .fit)
    }
    
    @ViewBuilder
    func createCheckmarkButton(itemId: String) -> some View {
        ZStack {
            Rectangle()
                .strokeBorder(Color.black, lineWidth: 1)
                .background(
                    Rectangle()
                        .fill(store.seletedInterestsIds.contains(itemId) ? Color.black : Color.white)
                )
                .frame(width: 20, height: 20)
                .onTapGesture {
                    if store.seletedInterestsIds.contains(itemId) {
                        store.send(.deselectInterest(itemId))
                    } else {
                        store.send(.selectInterest(itemId))
                    }
                }
            
            if store.seletedInterestsIds.contains(itemId) {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .medium))
            }
        }
    }
}

