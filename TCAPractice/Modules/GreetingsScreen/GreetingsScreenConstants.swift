//
//  GreetingsScreenConstants.swift
//  TCAPractice
//
//  Created by Rush_user on 02.09.2025.
//

import SwiftUI

extension GreetingsView {
    // MARK: - Constants
    enum Constants {
        // Overlay gradient
        static let overlayRactangleHeightMultiplier: CGFloat = 0.7
        static let rectangleGradient = Gradient(stops: [
            .init(color: .black, location: 0.0),
            .init(color: .black, location: 0.4),
            .init(color: .clear, location: 1.0)
        ])
        
        // Texts
        static let greetingText = "Online Personal\nStyling.\nOutfits for\nEvery Woman."
        static let quizButtonTitle = "TAKE A QUIZ"
        
        // Fonts and sizes
        static let greetingFontSize: CGFloat = 32
        static let greetingFontWeight: Font.Weight = .medium
        static let horizontalPadding: CGFloat = 40
        
        // Spacers
        static let spacerHeightTop: CGFloat = 80
        static let spacerHeightBottom: CGFloat = 62
        
        // Button dimensions
        static let quizButtonWidth: CGFloat = 350
        static let quizButtonHeight: CGFloat = 48
    }
}
