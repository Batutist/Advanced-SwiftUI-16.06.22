//
//  AlertInfo.swift
//  Advanced SwiftUI 16.06.22
//
//  Created by Sergey Kovalev on 6/17/22.
//

import SwiftUI

struct AlertInfo: Identifiable {
    var id = UUID()
    

    enum AlertType {
        case wrongEmailFormat
        case wrongPasswordFormat
        case signUpError
        case logInError
        case resetPasswordError
        case resetPassword
        case error
    }
    
    var alertType: AlertType
    let title: String
    let message: String
}
