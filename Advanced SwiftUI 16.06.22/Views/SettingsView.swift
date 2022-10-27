//
//  SettingsView.swift
//  Advanced SwiftUI 16.06.22
//
//  Created by Sergey Kovalev on 10/27/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color("settingsBackground")
                .ignoresSafeArea()
            VStack() {
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
