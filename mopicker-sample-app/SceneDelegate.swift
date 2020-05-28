//
//  SceneDelegate.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 19.03.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import SwiftUI
import AppsFlyerLib

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            if AppConstants.isOpenSource {
                window.rootViewController = UIHostingController(rootView: MainView())
            } else {
                window.rootViewController = UIHostingController(rootView: AuthView().environmentObject(FirebaseAuthService.shared))
            }
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        AppsFlyerTracker.shared().continue(userActivity, restorationHandler: nil)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            AppsFlyerTracker.shared().handleOpen(url, options: nil)
        }
    }


}

