//
//  String + Date Formatter.swift
//  FreeLife
//
//  Created by Jeferson Dias dos Santos on 05/05/25.
//

import Foundation
extension String {
    func toBRDateFormat() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: self) else {
            return self
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"
        outputFormatter.locale = Locale(identifier: "pt_BR")
        
        return outputFormatter.string(from: date)
    }
}
