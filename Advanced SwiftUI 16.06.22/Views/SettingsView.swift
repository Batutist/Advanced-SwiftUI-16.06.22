//
//  SettingsView.swift
//  Advanced SwiftUI 16.06.22
//
//  Created by Sergey Kovalev on 10/27/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isEditingNameTextfield = false
    @State private var isEditingTwitterTextfield = false
    @State private var isEditingSiteTextfield = false
    @State private var isEditingBioTextfield = false
    
    @State private var nameIconBounce = false
    @State private var twitterIconBounce = false
    @State private var siteIconBounce = false
    @State private var bioIconBounce = false
    
    @State private var name = ""
    @State private var twitter = ""
    @State private var site = ""
    @State private var bio = ""
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        
        ZStack {
            Color("settingsBackground")
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                Text("Settings")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                
                Text("Manage your Design+Code profile and account")
                    .font(.subheadline).opacity(0.7)
                
                
                GradientTextfield(isTextfieldActive: $isEditingNameTextfield, textfieldIconBounce: $nameIconBounce, text: $name, textfieldIcon: "textformat.alt", textPlaceHolder: "Your name")
                
                GradientTextfield(isTextfieldActive: $isEditingTwitterTextfield, textfieldIconBounce: $twitterIconBounce, text: $twitter, textfieldIcon: "scribble", textPlaceHolder: "Twitter profile")
                
                GradientTextfield(isTextfieldActive: $isEditingSiteTextfield, textfieldIconBounce: $siteIconBounce, text: $site, textfieldIcon: "link", textPlaceHolder: "Your personal website")
                
                GradientTextfield(isTextfieldActive: $isEditingBioTextfield, textfieldIconBounce: $bioIconBounce, text: $bio, textfieldIcon: "text.justify.leading", textPlaceHolder: "Write about yourself")
                
                GradientButtonBackground(buttonText: "Save Settings") {
                    print("save changes made by the user")
                }
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .preferredColorScheme(.dark)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
