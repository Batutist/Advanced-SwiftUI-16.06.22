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
    
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    
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
                
                // Button for change account image
                Button {
#warning("Open user's photo library")
                    showImagePicker.toggle()
                } label: {
                    
                    HStack(spacing: 12) {
                        TextfieldIcon(isActive: .constant(false), icon: "person.crop.circle", passedImage: $inputImage)
                            .padding(.leading, 8)
                        
                        GradientText(text: "Choose photo from library")
                        
                        Spacer()
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.1), lineWidth: 1)
                }
                .background(Color("textfieldBackground").cornerRadius(16))
                
                // Name Textfield
                GradientTextfield(isTextfieldActive: $isEditingNameTextfield, textfieldIconBounce: $nameIconBounce, text: $name, textfieldIcon: "textformat.alt", textPlaceHolder: "Your name")
                    .textInputAutocapitalization(.words)
                    .textContentType(.name)
                    .autocorrectionDisabled(true)
                
                // Twitter account Textfield
                GradientTextfield(isTextfieldActive: $isEditingTwitterTextfield, textfieldIconBounce: $twitterIconBounce, text: $twitter, textfieldIcon: "at", textPlaceHolder: "Twitter profile")
                    .textInputAutocapitalization(.none)
                    .keyboardType(.twitter)
                    .autocorrectionDisabled(true)
                
                
                // Personal website Textfield
                GradientTextfield(isTextfieldActive: $isEditingSiteTextfield, textfieldIconBounce: $siteIconBounce, text: $site, textfieldIcon: "link", textPlaceHolder: "Your personal website")
                    .textInputAutocapitalization(.none)
                    .keyboardType(.webSearch)
                    .autocorrectionDisabled(true)
                
                // Account description Textfield
                GradientTextfield(isTextfieldActive: $isEditingBioTextfield, textfieldIconBounce: $bioIconBounce, text: $bio, textfieldIcon: "text.justify.leading", textPlaceHolder: "Write about yourself")
                    .textInputAutocapitalization(.sentences)
                    .keyboardType(.default)
                
                
                // Save changes button
                GradientButtonBackground(buttonText: "Save Settings") {
                    print("save changes made by the user")
                    generator.selectionChanged()
                    #warning("no button action")
                }
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .preferredColorScheme(.dark)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
