//
//  ContentView.swift
//  AiGemini
//
//  Created by Natalia on 10.09.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  
    var body: some View {
       ChatView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
