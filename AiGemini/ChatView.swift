//
//  ChatView.swift
//  AiGemini
//
//  Created by Natalia on 10.09.24.
//

import SwiftUI
import GoogleGenerativeAI

import SwiftUI
import GoogleGenerativeAI

struct ChatView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    @State private var userPrompt: String = ""
    @State private var isLoading: Bool = false
    @State private var conversationHistory: [(String, String)] = []

    var body: some View {
        VStack {
            Text("Welcome to Gemini AI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.indigo)
                .padding(.top, 40)
            
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(conversationHistory.indices, id: \.self) { index in
                            let (userMessage, geminiResponse) = conversationHistory[index]
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(userMessage)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    if !geminiResponse.isEmpty {
                                        Text(geminiResponse)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .id(index)
                            }
                        }
                    }
                    .padding()
                }
                .onChange(of: conversationHistory.count) { _ in
                    withAnimation {
                        scrollViewProxy.scrollTo(conversationHistory.indices.last)
                    }
                }
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                }
            }
            
            HStack {
                TextField("Enter your prompt...", text: $userPrompt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: generateResponse) {
                    Text("Generate")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
    }

    private func generateResponse() {
        guard !userPrompt.isEmpty else { return }
        
        isLoading = true
        
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                let responseText = result.text ?? "No response found"
                
                conversationHistory.append((userPrompt, responseText))
                userPrompt = ""
                
                isLoading = false
            } catch {
                isLoading = false
                let errorMessage = "Something went wrong\n\(error.localizedDescription)"
                conversationHistory.append((userPrompt, errorMessage))
                userPrompt = ""
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
