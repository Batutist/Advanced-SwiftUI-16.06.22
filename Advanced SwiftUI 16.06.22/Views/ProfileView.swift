//
//  ProfileView.swift
//  Advanced SwiftUI 16.06.22
//
//  Created by Sergey Kovalev on 6/17/22.
//

import SwiftUI
import FirebaseAuth


struct ProfileView: View {
    
    @State private var alertInfo: AlertInfo?
    @State private var showSettingsView: Bool = false
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        ZStack {
            Image("background-2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                card
                
                logOutButton
            }
        }
        .preferredColorScheme(.dark)
        .alert(item: $alertInfo) { info in
            Alert(title: Text(info.title), message: Text(info.message), dismissButton: .cancel())
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
    }
    
    private var card: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    // User avartar
//                    ZStack {
//                        Circle()
//                            .foregroundColor(Color("pink-gradient-1"))
//
//                        Image(systemName: "person.fill")
//                            .foregroundColor(.white)
//                            .font(.system(size: 24, weight: .medium, design: .rounded))
//                    }
//                    .frame(width: 66, height: 66, alignment: .center)
                    
                    GradientProfilePictureView(profilePicture: UIImage(named: "Profile")!)
                        .frame(width: 66, height: 66, alignment: .center)
                    
                    // User name
                    VStack(alignment: .leading) {
                        Text("Sergey Kovalev")
                            .font(.title2).bold()
                        
                        Text("View profile")
                            .opacity(0.7)
                            .font(.footnote)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                    
                    // settings button
                    Button {
                        print("settings button pressed")
                        showSettingsView.toggle()
                    } label: {
                        TextfieldIcon(isActive: .constant(true), icon: "gearshape.fill")
                    }
                }
                
                // Divider
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white.opacity(0.1))
                
                Text("Performer in the iconic show Mystere")
                    .font(.title2).bold()
                    .foregroundColor(.white)
                
                Label("Awarded 10 certificates since September 2020", systemImage: "calendar")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.footnote)
                
                // Divider
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white.opacity(0.1))
                
                HStack(spacing: 16) {
                    Image("Twitter")
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    Image(systemName: "link")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                    
                    Text("designcode.io")
                        .font(.footnote)
                }
                .foregroundColor(.white.opacity(0.7))
            }
            .padding(16)
            
            // Gradient button
            GradientButtonBackground(buttonText: "Purchase LifeTime Pro Plan") {
                print("purchase button tapped")
            }
            .padding(.horizontal, 16)
            
            // restore your purchases button
            
            Button {
                print("restore purchases button tapped")
            } label: {
                GradientText(text: "Restore purchases")
                    .font(.footnote.bold())
            }
            .padding(.bottom)
        }
        .background(
            RoundedRectangle(
                cornerRadius: 30,
                style: .continuous)
            .stroke(Color.white.opacity(0.2))
            .background(Color("secondaryBackground").opacity(0.5))
            .background(VisualEffectBlur(blurStyle: .dark))
            .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    private var logOutButton: some View {
        Button {
            print("Log out button tapped")
            signOut()
        } label: {
            Image(systemName: "arrow.turn.up.forward.iphone.fill")
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 0.0, z: 1.0))
                .background(
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        .frame(width: 40, height: 40, alignment: .center)
                        .overlay(
                            VisualEffectBlur(blurStyle: .dark)
                                .cornerRadius(20)
                                .frame(width: 40, height: 40, alignment: .center)
                        )
                )
        }
        .padding()
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            presentationMode.wrappedValue.dismiss()
        } catch let error {
            alertInfo = AlertInfo(alertType: .error, title: "An error occure", message: error.localizedDescription)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
