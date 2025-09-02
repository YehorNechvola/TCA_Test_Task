//
//  QuizInterestsView.swift
//  TCAPractice
//
//  Created by Rush_user on 29.08.2025.
//

import SwiftUI
import ComposableArchitecture

struct InterestsView: View {
    
    // MARK: - Store
    @Perception.Bindable var store: StoreOf<InterestsQuizStore>
    
    // MARK: - Body
    var body: some View {
        VStack {
            // Display question text
            Text(store.question.question)
                .font(Constants.questionFont)
            
            // Render UI based on question type
            switch store.question.type {
            case .interests:
                createList()
            case .styles:
                createCollection(columns: 2)
            case .colors:
                createCollection(columns: 3)
            }
            
            // Continue button
            Button {
                store.send(.continueQuiz)
            } label: {
                Text("Continue")
                    .frame(width: Constants.continueButtonWidth, height: Constants.continueButtonHeight)
                    .background(Color.black)
                    .foregroundColor(.white)
            }
            .contentShape(Rectangle())
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(store.question.title)
                    .font(Constants.toolbarTitleFont)
                    .foregroundColor(.black)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            // Load previously saved selected answers
            store.send(.getSavedAnswersId)
        }
    }
}

//MARK: - Private Methods
private extension InterestsView {
    
    // MARK: - List
    /// Creates a vertical list of answers for "interests" type questions
    @ViewBuilder
    private func createList() -> some View {
        List(store.question.answers, id: \.id) { answer in
            WithPerceptionTracking {
                createListRow(answer: answer)
            }
        }
        .listStyle(.plain)
    }
    
    /// Single row for a list, includes title, description and checkmark
    @ViewBuilder
    private func createListRow(answer: Answer) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(answer.name)
                    .font(Constants.listAnswerTitleFont)
                Text(answer.description ?? "")
                    .font(Constants.listAnswerDescriptionFont)
            }
            
            Spacer()
            
            createCheckmarkButton(itemId: answer.id)
        }
        .frame(height: Constants.listRowHeight)
        .listRowSeparator(.hidden)
        .padding(.horizontal, Constants.listHorizontalPadding)
        .overlay(Rectangle()
            .stroke(Color.black, lineWidth: Constants.listOverlayLineWidth))
    }
    
    // MARK: - Collection
    /// Creates a grid collection for "styles" and "colors" type questions
    @ViewBuilder
    private func createCollection(columns: Int) -> some View {
        let gridItems = Array(repeating: GridItem(.flexible(), spacing: Constants.collectionSpacing), count: columns)
        
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: Constants.collectionSpacing) {
                ForEach(store.question.answers, id: \.id) { answer in
                    WithPerceptionTracking {
                        createCollectionCell(answer: answer)
                    }
                }
            }
            .padding(.horizontal, Constants.collectionPaddingHorizontal)
            .padding(.vertical, Constants.collectionPaddingVertical)
        }
    }
    
    /// Single cell for the grid, includes image/color and checkmark
    @ViewBuilder
    private func createCollectionCell(answer: Answer) -> some View {
        ZStack {
            VStack {
                // Show image if available, otherwise colored rectangle
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
                        .frame(width: Constants.collectionPlaceholderImageSize,
                               height: Constants.collectionPlaceholderImageSize)
                }
                
                Text(answer.name.uppercased())
                    .font(Constants.collectionNameFont)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            // Checkmark button on top-right
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    createCheckmarkButton(itemId: answer.id)
                }
                Spacer()
            }
        }
        .padding(Constants.collectionCellPadding)
        .overlay(Rectangle().stroke(Color.black, lineWidth: Constants.listOverlayLineWidth))
        .aspectRatio(1, contentMode: .fit)
    }
    
    // MARK: - Checkmark Button
    /// Creates a checkmark button overlay for both list rows and collection cells
    @ViewBuilder
    private func createCheckmarkButton(itemId: String) -> some View {
        ZStack {
            Rectangle()
                .strokeBorder(Color.black, lineWidth: Constants.listOverlayLineWidth)
                .background(
                    Rectangle()
                        .fill(store.seletedInterestsIds.contains(itemId) ? Color.black : Color.white)
                )
                .frame(width: Constants.checkmarkSize, height: Constants.checkmarkSize)
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
                    .font(Constants.checkmarkFont)
            }
        }
    }
}
