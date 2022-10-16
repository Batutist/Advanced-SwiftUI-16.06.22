//
//  Extensions.swift
//  Advanced SwiftUI 11.06.22
//
//  Created by Sergey Kovalev on 6/11/22.
//

import SwiftUI

extension View {
    public func gradientForegroundText(colors: [Color]) -> some View {
        
        self.overlay(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPassword() -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
            
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",regex)
        return passwordCheck.evaluate(with: password)
    }
}
