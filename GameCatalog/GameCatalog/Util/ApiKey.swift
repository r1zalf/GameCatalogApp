//
//  ApiKey.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 10/11/23.
//

import Foundation

var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
        fatalError("filePath not found")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
        fatalError("API_KEY not found")
    }
    return value
}
