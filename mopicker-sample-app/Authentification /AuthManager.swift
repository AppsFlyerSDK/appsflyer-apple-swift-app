//
//  LoginManager.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 07.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Combine
import AppsFlyerLib

class AuthManager: ObservableObject {
    static var shared = AuthManager()
    var googleAuthSub: AnyCancellable?
    
    var isSignedIn = PassthroughSubject<Bool, Never>()
    
    @Published var userDidSignIn: Bool = false {
        didSet {
            isSignedIn.send(self.userDidSignIn)
        }
    }
    
    private var googleAuth = GoogleAuthService.googleSignIn
    
    private init() {
        subscribe()
    }
    
    private func subscribe() {
        self.googleAuthSub = googleAuth.isSignedIn.sink(receiveValue: { userIsSignedIn in
            AppsFlyerTracker.shared().trackEvent("af_google_login", withValues: nil)
            self.userDidSignIn = userIsSignedIn
            AFEventRate
        })
    }
    
    func signOut() {
        googleAuth.userDidSignOut()
    }
    
    deinit {
        print("OBJ deinitialized")
    }
}
