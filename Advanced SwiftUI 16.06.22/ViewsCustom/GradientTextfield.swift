//
//  GradientTextfield.swift
//  Advanced SwiftUI 16.06.22
//
//  Created by Sergey Kovalev on 10/31/22.
//

import SwiftUI

struct GradientTextfield: View {
    
    @Binding var isTextfieldActive: Bool
    @Binding var textfieldIconBounce: Bool
    @Binding var text: String
    
    var textfieldIcon: String
    var textPlaceHolder: String
    var backgroundColor: String = "textfieldBackground"
    
    private let generator = UISelectionFeedbackGenerator()
    
    
    var body: some View {
        HStack(spacing: 12) {
            TextfieldIcon(isActive: $isTextfieldActive, icon: textfieldIcon, passedImage: .constant(nil))
                .padding(.leading, 8)
                .scaleEffect(textfieldIconBounce ? 1.2 : 1)
            
            TextField(textPlaceHolder, text: $text) { isActive in
                // haptic feedback for user on tap
                generator.selectionChanged()
                // glow the icon when email textfield activated
                withAnimation {
                    isTextfieldActive = isActive
                }
                // Bounce animation for the icon
                if isActive {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                        textfieldIconBounce.toggle()
                    }
                    // End of the bounce animation 0.25 sec after
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                            textfieldIconBounce = false
                        }
                    }
                }
            }
            .colorScheme(.dark)
            .foregroundColor(.white).opacity(0.7)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.white, lineWidth: 1)
                .blendMode(.overlay)
        )
        .background(
            Color(backgroundColor)
                .cornerRadius(16))
        
    }
}

struct GradientTextfield_Previews: PreviewProvider {
    static var previews: some View {
        GradientTextfield(isTextfieldActive: .constant(true), textfieldIconBounce: .constant(false), text: .constant(""), textfieldIcon: "envelope.fill", textPlaceHolder: "Some texxxxxtfield")
    }
}
