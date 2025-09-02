//
//  InterestsScreenConstants.swift
//  TCAPractice
//
//  Created by Rush_user on 02.09.2025.
//

import SwiftUI

extension InterestsView {
    // MARK: - Constants
    enum Constants {
        // Fonts
        static let questionFont = Font.system(size: 26, weight: .medium, design: .default)
        static let listAnswerTitleFont = Font.system(size: 13, weight: .medium, design: .default)
        static let listAnswerDescriptionFont = Font.system(size: 14, weight: .light, design: .default)
        static let collectionNameFont = Font.system(size: 13, weight: .light)
        static let checkmarkFont = Font.system(size: 12, weight: .medium)
        static let toolbarTitleFont = Font.headline
        
        // List
        static let listRowHeight: CGFloat = 72
        static let listHorizontalPadding: CGFloat = 16
        static let listOverlayLineWidth: CGFloat = 1
        
        // Checkmark
        static let checkmarkSize: CGFloat = 20
        
        // Button
        static let continueButtonWidth: CGFloat = 350
        static let continueButtonHeight: CGFloat = 48
        
        // Collection
        static let collectionSpacing: CGFloat = 16
        static let collectionPaddingHorizontal: CGFloat = 16
        static let collectionPaddingVertical: CGFloat = 8
        static let collectionCellPadding: CGFloat = 8
        static let collectionPlaceholderImageSize: CGFloat = 32
    }
}
