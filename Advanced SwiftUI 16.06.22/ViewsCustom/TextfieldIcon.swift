//
//  TextfieldIcon.swift
//  Advanced SwiftUI 11.06.22
//
//  Created by Sergey Kovalev on 6/13/22.
//

import SwiftUI

struct TextfieldIcon: View {
    @Binding var isActive: Bool
    var icon: String
    @Binding var passedImage: UIImage?
    
    var gradientColors: [Color] = [
        Color(red: 101/255, green: 134/255, blue: 1),
        Color(red: 1, green: 64/255, blue: 80/255),
        Color(red: 109/255, green: 1, blue: 185/255),
        Color(red: 39/255, green: 232/255, blue: 1)
    ]
    
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .dark)
            
            ZStack {
                
                if isActive {
                    AngularGradient(colors: gradientColors, center: .center, angle: .degrees(0))
                        .blendMode(.overlay)
                        .blur(radius: 10)
                }
                
                Color("tertiaryBackground")
                    .cornerRadius(12)
                    .opacity(0.8)
                    .blur(radius: 3)
            }
            
        }
        .cornerRadius(12)
        .overlay(
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(.white)
                    .blendMode(.overlay)
                
                if let image = passedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28, alignment: .center)
                        .cornerRadius(8)
                } else {
                    Image(systemName: icon)
                        .gradientForegroundText(colors: [Color("pink-gradient-1"), Color("pink-gradient-2")])
                        .font(.headline)
                }
            }
        )
        .frame(width: 36, height: 36, alignment: .center)
        .padding(.vertical, 8)
    }
}

struct TextfieldIcon_Previews: PreviewProvider {
    static var previews: some View {
        TextfieldIcon(isActive: .constant(true), icon: "key.fill", passedImage: .constant(nil))
    }
}
