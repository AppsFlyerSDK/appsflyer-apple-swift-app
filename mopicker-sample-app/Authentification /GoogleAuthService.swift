//
//  GoogleSignInSession.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 06.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import GoogleSignIn
import Combine

class GoogleAuthService: ObservableObject {
    
    static let googleSignIn = GoogleAuthService()
    
    //    @Published var isSignedIn: Bool = false {
    //        didSet {
    //            didChange.send(self)
    //        }
    //    }
    
    @Published var isSignedIn = PassthroughSubject<Bool, Never>()
    
    private init() { }
    
    public func setClientId(clientID: String) {
        GIDSignIn.sharedInstance().clientID = clientID
    }
    
    public func userDidSignIn(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        } else {
            isSignedIn.send(true)
        }
    }
    
    public func userDidDisconnected(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            GIDSignIn.sharedInstance()?.signOut()
        } else {
            print(error.localizedDescription)
        }
    }
    
    public func userDidSignOut() {
        GIDSignIn.sharedInstance()?.signOut()
        isSignedIn.send(false)
    }
    
    public func setDelegate(delegateClass: GIDSignInDelegate) {
        GIDSignIn.sharedInstance().delegate = delegateClass
    }
    
    public func urlHandler(url: URL) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    public func signInButtonPressed() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
    }
}

enum PageStatus {
    case ready (nextPage: Int)
    case loading (page: Int)
    case done
}

enum MyError: Error {
    case limitError
    case httpError
}
