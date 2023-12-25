//
//  String+DateCustome.swift
//  GameCatalog
//
//  Created by Rizal Fahrudin on 06/12/23.
//

import Foundation

extension String {
    func dateCustome() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let dateString = dateFormatter.string(from: date)
            let result = "Release: \(dateString)"
            return result
        } else {
            return self
        }
    }
}
