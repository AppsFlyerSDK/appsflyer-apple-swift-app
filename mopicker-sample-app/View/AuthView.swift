//
//  LoginView.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 30.04.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI
import AppsFlyerLib


struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: FirebaseAuthService
    @ObservedObject var auth = AuthManager.shared
    @State var isMainviewPresented = false
    @State var isNewUser = false
    
    private func signIn() {
        session.signIn(email: email, password: password) { (authResult, authError) in
            if let error = authError {
                self.error = error.localizedDescription
            } else {
                DispatchQueue.global(qos: .background).async {
                    AppsFlyerTracker.shared().trackEvent("af_regular_login", withValues: nil)
                }
                withAnimation {
                    self.isMainviewPresented.toggle()
                }
                self.error = ""
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
            Text("Sign in to continue.")
                .font(.system(size: 18, weight: .heavy, design: .default))
                .foregroundColor(Color.gray)
            
            VStack(alignment: .center, spacing: 20) {
                TextField("Enter your e-mail", text: $email)
                    .font(.system(size: 14))
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.white, lineWidth: 1))
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.white, lineWidth: 1))
                
                Button(action: signIn) {
                    Text("Sign In!")
                        .frame(minWidth: 0,  maxWidth: .infinity)
                        .frame(height: 50)
                        .font(.system(size: 14))
                        .foregroundColor(Color.black)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(5)
                }
                LoginServicesView()
            }.padding(.vertical, 64)
            
            
            
            HStack {
                Text("Please, sign up, if you are new user.")
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                NavigationLink(destination: SignUpView(), isActive: self.$isNewUser) {
                    Text("Sign Up!")
                }
            }
            
            NavigationLink(destination: MainView()) {
                Text("Use app without signing in.").font(.system(size: 14, weight: .light, design: .rounded))
            }.padding(.top, 10).onTapGesture {
                AppsFlyerTracker.shared().trackEvent("af_regular_login", withValues: nil)
            }
            
            
            if (!error.isEmpty) {
                Text(error)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14, weight: .semibold, design: .default))
                    .foregroundColor(.red)
                    .padding(.top, 10)
            } else  {
                NavigationLink(destination: MainView(), isActive: self.$isMainviewPresented) {
                    Text("")
                }
                
                NavigationLink(destination: MainView(), isActive: $auth.userDidSignIn) {
                    Text("")
                }
            }
        }.padding(.horizontal, 19)
    }
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmedPassword: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: FirebaseAuthService
    @State var signUpSuccess = false
    
    func signUp() {
        session.signUp(email: email, password: password) { (authResult, authError) in
            if let error = authError {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
                self.confirmedPassword = ""
                self.signUpSuccess = true
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Create new account!")
                .font(.largeTitle)
            
            VStack(alignment: .center, spacing: 20) {
                TextField("Enter your e-mail", text: $email)
                    .font(.system(size: 14))
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.white, lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.white, lineWidth: 1))
                
                SecureField("Confirm password", text: $confirmedPassword)
                    .font(.system(size: 14))
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.white, lineWidth: 1))
            }.padding(.vertical, 64)
            
            NavigationLink(destination: SignInView(), isActive: $signUpSuccess) {
                 Button(action: signUp) {
                                   Text("Create Account!")
                                   .frame(minWidth: 0,  maxWidth: .infinity)
                                   .frame(height: 50)
                                   .font(.system(size: 14))
                                   .foregroundColor(Color.black)
                                   .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                   .cornerRadius(5)
                           }
            }.buttonStyle(PlainButtonStyle())
            
            if (!error.isEmpty) {
                Text(error)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14, weight: .semibold, design: .default))
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
            
        }.padding(.horizontal, 19)
    }
}

struct AuthView: View {
    @EnvironmentObject var loginSession: FirebaseAuthService
    
    func getUser() {
        loginSession.listenToAuth()
    }

    var body: some View {
        NavigationView {
            if (loginSession.user != nil) {
                Text("Hello user")
            } else {
                SignInView().environmentObject(FirebaseAuthService.shared)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(FirebaseAuthService.shared)
    }
}



struct LoginServicesView: View {
    
    var body: some View {
        GoogleButtonView()
    }
    
}
