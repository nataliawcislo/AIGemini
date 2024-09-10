//
//  GeminiAIClient.swift
//  AiGemini
//
//  Created by Natalia on 10.09.24.
//

import SwiftUI
import GoogleGenerativeAI

extension GeminiAIClient {
    func generateResponse(for message: String, completion: @escaping (String) -> Void) {
        // Zakładam, że masz metodę do generowania odpowiedzi
        // Implementacja zależy od API Gemini
        // Przykład:
        let request = GenerateRequest(message: message)
        performRequest(request) { result in
            switch result {
            case .success(let response):
                completion(response.text)
            case .failure(let error):
                completion("Błąd: \(error.localizedDescription)")
            }
        }
    }
}
