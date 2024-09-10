//
//  APIKey.swift
//  AiGemini
//
//  Created by Natalia on 10.09.24.
//

import Foundation


enum APIKey {
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "PropertyList", ofType: "plist") else {
            fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
        }
        
        guard let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't load 'GenerativeAI-Info.plist'.")
        }
        
        guard let value = plist.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        
        if value.starts(with: "_") {
            fatalError("Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key.")
        }
        
        return value
    }
}
