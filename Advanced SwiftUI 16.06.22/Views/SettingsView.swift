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
            VStack(alignment: .leading) {
                Text("Settings")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                
                Text("Manage your Design+Code profile and account")
                    .font(.subheadline)
                    
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
