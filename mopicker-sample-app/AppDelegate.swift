//
//  AppDelegate.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 19.03.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import AppsFlyerLib
import SDWebImageSwiftUI


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let googleSignIn = GoogleAuthService.googleSignIn
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else {return true}
        let plistDict = NSDictionary(contentsOfFile: path)

        if AppConstants.isOpenSource {
            AppsFlyerTracker.shared().isDebug = true
        } else {
            FirebaseApp.configure()
            googleSignIn.setDelegate(delegateClass: self)
        }
        
        AppsFlyerTracker.shared().delegate = self
        
        if let plist = plistDict, let devKey = plist["af_dev_key"], let appID = plist["af_app_id"], let googleClientID = plist["google_client_id"] {
            AppsFlyerTracker.shared().appsFlyerDevKey = devKey as! String
            AppsFlyerTracker.shared().appleAppID = appID as! String
            googleSignIn.setClientId(clientID: googleClientID as! String)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendLaunch),name: UIApplication.didBecomeActiveNotification, object: nil)
        
        return true
    }
    
    @objc func sendLaunch(app:Any) {
        AppsFlyerTracker.shared().trackAppLaunch()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerTracker.shared().handleOpen(url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AppsFlyerTracker.shared().continue(userActivity, restorationHandler: nil)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppsFlyerTracker.shared().handlePushNotification(userInfo)
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        SDWebImageManager.shared.imageCache.clear(with: .all, completion: nil)
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk(onCompletion: nil)
    }
    
}

extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        googleSignIn.userDidSignIn(signIn, didSignInFor: user, withError: error)
       }
       
       func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        googleSignIn.userDidDisconnected(signIn, didDisconnectWith: user, withError: error)
       }
}

extension AppDelegate: AppsFlyerTrackerDelegate {
    func onConversionDataFail(_ error: Error) {
        print("Error", error.localizedDescription)
    }
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        print("Conversion data success", conversionInfo)
    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        print("Error", error.localizedDescription)
    }
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        print("On app open attribution data", attributionData)
    }
}

