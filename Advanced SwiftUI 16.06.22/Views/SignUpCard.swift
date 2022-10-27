//
//  SignInCard.swift
//  Advanced SwiftUI 11.06.22
//
//  Created by Sergey Kovalev on 6/11/22.
//

import SwiftUI
import AudioToolbox
import FirebaseAuth

struct SignUpCard: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isEmailActive = false
    @State private var isPasswordActive = false
    @State private var emailIconBounce = false
    @State private var passwordIconBounce = false
    @State private var alertInfo: AlertInfo?
    @State private var showProfileView = false
    @State private var isSignUpScreen = true
    @State private var cardRotationAngle = 0.0
    @State private var backgroungFadeToggle = true
    
    
    enum LoginStatus {
        case signUp
        case signIn
    }
    
    // SignIn func for existed user or SignUp func for a new user
    var loginStatus: LoginStatus = .signUp
    
    // generator for taptic feedback
    private let generator = UISelectionFeedbackGenerator()
    
    
    var body: some View {
        
        ZStack {
            Image(isSignUpScreen ? "background-3" : "background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(backgroungFadeToggle ? 1.0 : 0.0)
            
            Color("secondaryBackground")
                .ignoresSafeArea()
                .opacity(backgroungFadeToggle ? 0.0 : 1.0)
            
            card
        }
        .onAppear(
//            email = ""
//            password = ""
        )
        .fullScreenCover(isPresented: $showProfileView) {
            ProfileView()
        }
    }
    
    //MARK: Card component
    private var card: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                
                Text(isSignUpScreen ? "Sign Up" : "Sign In")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                
                Text ("Access to the 120+ hours of cources, livestreams and turtorials.")
                    .font(.subheadline)
                    .foregroundColor(.white).opacity(0.7)
                
                // Email address textfield
                emailTextField
                    .frame(height: 52)
                    .background(Color("secondaryBackground")
                        .opacity(0.8)
                        .cornerRadius(16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.white, lineWidth: 1)
                            .blendMode(.overlay))
                
                // Password textfield
                passwordTextField
                    .frame(height: 52)
                    .background(Color("secondaryBackground")
                        .opacity(0.8)
                        .cornerRadius(16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.white, lineWidth: 1)
                            .blendMode(.overlay))
                
                //MARK: Create account button
                GradientButtonBackground(buttonText: isSignUpScreen ? "Create an account" : "Sign In", action: {
                    generator.selectionChanged()
                    onCreateAccountTapped()
                })
                .alert(item: $alertInfo, content: { info in
                    Alert(title: Text(info.title),
                          message: Text(info.message))
                })
                .onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        guard user != nil else {
                            return
                        }
                        showProfileView.toggle()
                    }
                }
                
                // Hide Privacy policy text and Divider if on Sign in screen
                if isSignUpScreen {
                    Text("By clicking on Sign up, you agree to our Terms of service and Privacy policy.")
                        .foregroundColor(.white).opacity(0.7)
                        .font(.footnote)
                    
                    Divider()
                        .colorScheme(.dark)
                }
                
                
                //MARK: Change to sign in screen button
                Button {
                    // Smooth transition for background images
                    withAnimation(.easeInOut(duration: 0.35)) {
                        backgroungFadeToggle.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                backgroungFadeToggle.toggle()
                            }
                        }
                    }
                    
                    // changing card from sign in to sign up
                    withAnimation(.easeInOut(duration: 0.7)) {
                        isSignUpScreen.toggle()
                        
                        cardRotationAngle += 180
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(isSignUpScreen ? "Alredy have an account?" : "Don't have an account?")
                            .font(.footnote)
                            .foregroundColor(.white).opacity(0.7)
                        GradientText(text: isSignUpScreen ? "Sign In" : "Sign Up")
                            .font(.footnote.bold())
                    }
                }
                
                // Only visible if on Sign In screen
                if !isSignUpScreen {
                    //MARK: Reset password button
                    Button {
                        sendPasswordResetEmail()
                    } label: {
                        HStack(spacing: 4) {
                            Text("Forgot password?")
                                .font(.footnote)
                                .foregroundColor(.white).opacity(0.7)
                            
                            GradientText(text: "Reset Password")
                                .font(.footnote.bold())
                        }
                    }
                    
                    
                    Divider()
                        .colorScheme(.dark)
                    
                    // MARK: Sign in with Apple button
                    Button {
                        //TODO: sign in with apple action
                    } label: {
                        SignInWithAppleButton()
                            .frame(height: 50)
                            .cornerRadius(16)
                    }
                    
                }
            }
            .padding(20)
        }
        .rotation3DEffect(Angle(degrees: cardRotationAngle),
                          axis: (x: 0.0, y: 1.0, z: 0.0))
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(Color.white).opacity(0.2)
                .background(Color("secondaryBackground").opacity(0.5))
                .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
                .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30))
        .cornerRadius(30)
        .padding(.horizontal)
        .rotation3DEffect(Angle(degrees: cardRotationAngle),
                          axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    //MARK: - Email textfield
    private var emailTextField: some View {
        HStack(spacing: 12) {
            TextfieldIcon(isActive: $isEmailActive, icon: "envelope.fill")
                .padding(.leading, 8)
                .scaleEffect(emailIconBounce ? 1.2 : 1)
            
            TextField("Email address", text: $email) { isActive in
                // haptic feedback for user on tap
                generator.selectionChanged()
                // glow the icon when email textfield activated
                withAnimation {
                    isEmailActive = isActive
                    isPasswordActive = false
                }
                // Bounce animation for the icon
                if isActive {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                        emailIconBounce.toggle()
                    }
                    // End of the bounce animation 0.25 sec after
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                            emailIconBounce = false
                        }
                    }
                }
            }
            .colorScheme(.dark)
            .foregroundColor(.white).opacity(0.7)
            .autocapitalization(.none)
            .textContentType(.emailAddress)
        }
    }
    
    //MARK: - Password textfield
    private var passwordTextField: some View {
        HStack(spacing: 12) {
            TextfieldIcon(isActive: $isPasswordActive, icon: "key.fill")
                .padding(.leading, 8)
                .scaleEffect(passwordIconBounce ? 1.2 : 1.0)
            
            SecureField("Password", text: $password)
                .colorScheme(.dark)
                .foregroundColor(.white).opacity(0.7)
                .autocapitalization(.none)
                .textContentType(.password)
            // TODO: Make correct animation and logic for gloing icon when password textfield is active
                .onTapGesture {
                    //haptic feedback for user on tap
                    generator.selectionChanged()
                    // glow effect for the icon
                    withAnimation {
                        isPasswordActive = true
                        isEmailActive = false
                    }
                    // Icon bounce animation beginning
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                        passwordIconBounce.toggle()
                    }
                    // Icon bounce animation ending
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                            passwordIconBounce = false
                        }
                    }
                }
        }
    }
    
    //MARK: - Create account button method
    // On create account button
    private func onCreateAccountTapped() {
        emailAndPasswordValidation()
    }
    
    // Checking format of provided email and password. Creates an account
    private func emailAndPasswordValidation() {
        let email = email.lowercased()
        
        // check email format. If its wrong show alert
        if !email.isValidEmail() {
            alertInfo = AlertInfo(alertType: .wrongEmailFormat, title: "Email format is wrong.", message: "Check your information please")
            
            // Check password format. If its wrong show alert
        } else if !password.isValidPassword() {
            alertInfo = AlertInfo(alertType: .wrongPasswordFormat, title: "Password format is wrong.", message: "Password should be minimum 8 characters length, have at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number")
            
            // If email and passwort are correct create a new user
        } else {
            if isSignUpScreen {
                createUser()
            } else {
                signInToAccount()
            }
        }
    }
    
    // MARK: - Creating a new user method
    private func createUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                let errorMessage = error?.localizedDescription ?? "Try again"
                alertInfo = AlertInfo(alertType: .signUpError, title: "Failed to create an account.", message: errorMessage)
                return
            }
            print("User was created")
        }
    }
    
    //MARK: - Sign in with existing user method
    private func signInToAccount() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                alertInfo = AlertInfo(alertType: .logInError, title: "Failed to log in to your account.", message: "\(error?.localizedDescription ?? "error")")
                return
            }
            print("Existed user signed in successfully")
        }
    }
    
    //MARK: - Send password reset Email method
    private func sendPasswordResetEmail() {
        let email = email.lowercased()
        
        if !email.isValidEmail() {
            alertInfo = AlertInfo(alertType: .wrongEmailFormat, title: "Email format is wrong.", message: "Please chech your entered Email")
        } else {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                guard error == nil else {
                    alertInfo = AlertInfo(alertType: .resetPasswordError, title: "Failed to send a link to reset your password", message: error!.localizedDescription)
                    return
                }
                alertInfo = AlertInfo(alertType: .resetPassword, title: "Password reset Email sent", message: "Check your inbox for an Email to reset your password")
            }
        }
    }
}

struct SignInCard_Previews: PreviewProvider {
    static var previews: some View {
        SignUpCard()
            .previewDevice("iPhone 12 Pro")
    }
}
