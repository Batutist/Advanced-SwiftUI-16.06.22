//
//  GradientText.swift
//  Advanced SwiftUI 11.06.22
//
//  Created by Sergey Kovalev on 6/13/22.
//

import SwiftUI

struct GradientText: View {
    var colors: [Color] = [Color("pink-gradient-1"), Color("pink-gradient-2")]
    var text: String
    
    var body: some View {
        Text(text)
        // adding background gradient to the text through the extension
            .gradientForegroundText(colors: colors)
    }
}
