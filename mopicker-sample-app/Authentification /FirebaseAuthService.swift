//
//  LoginSession.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 30.04.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI
import Combine
import Firebase


final class FirebaseAuthService: ObservableObject {
    
    static var shared = FirebaseAuthService()
    private var didChange = PassthroughSubject<FirebaseAuthService, Never>()
    var loginHandler: AuthStateDidChangeListenerHandle?
    
    @Published var user: User? {
        didSet {
            didChange.send(self)
        }
    }
    
    public func listenToAuth() {
        loginHandler = Auth.auth().addStateDidChangeListener({ (auth, user) in
            guard let loginUser = user else { return }
            var userEmail: String = "No email"
            
            if let email = loginUser.email {
                userEmail = email
            }
            self.user = User(uid: loginUser.uid, email: userEmail)
        })
    }
    
    public func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    public func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func unbind() {
        if let loginHandler = loginHandler {
            Auth.auth().removeStateDidChangeListener(loginHandler)
        }
    }
    
    deinit {
        unbind()
    }
}

