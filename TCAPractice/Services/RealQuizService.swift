//
//  RealQuizService.swift
//  TCAPractice
//
//  Created by Rush_user on 02.09.2025.
//

import Foundation

final class RealQuizService: QuizServiceProtocol {
    
    enum Endpoints {
        static let getQuizEndpoint: URL? = URL(string: "https://68b6efd673b3ec66cec336ce.mockapi.io/getQuiz/questions")
    }
    
    func getUserQuiz() async -> [Question]? {
        guard let url = Endpoints.getQuizEndpoint else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                return nil
            }
            
            let decoder = JSONDecoder()
            return try decoder.decode([Question].self, from: data)
        } catch {
            print("❌ Error fetching quiz: \(error)")
            return nil
        }
    }
}
