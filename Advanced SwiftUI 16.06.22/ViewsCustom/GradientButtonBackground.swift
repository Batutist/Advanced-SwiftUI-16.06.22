//
//  GradientButtonBackground.swift
//  Advanced SwiftUI 11.06.22
//
//  Created by Sergey Kovalev on 6/13/22.
//

import SwiftUI

struct GradientButtonBackground: View {
    @State private var angle = 0.0
    
    var buttonText: String
    var action: () -> Void
    
    var gradientColors: [Color] = [
        Color(red: 101/255, green: 134/255, blue: 1),
        Color(red: 1, green: 64/255, blue: 80/255),
        Color(red: 109/255, green: 1, blue: 185/255),
        Color(red: 39/255, green: 232/255, blue: 1)
    ]
    
    var body: some View {
        Button (action: action,
                label: {
            ZStack {
                AngularGradient(colors: gradientColors, center: .center, angle: .degrees(angle))
                    .blendMode(.overlay)
                    .blur(radius: 8)
                    .mask(RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .frame(height: 50)
                        .blur(radius: 8)
                    )
                    .onAppear() {
                        withAnimation(.linear(duration: 4)) {
                            angle += 360
                        }
                    }
                
                GradientText(text: buttonText)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("tertiaryBackground")
                        .opacity(0.9)
                        .cornerRadius(16))
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(.white, lineWidth: 1)
                        .opacity(0.7))
                
            }
            .frame(height: 50)
        })
    }
}
