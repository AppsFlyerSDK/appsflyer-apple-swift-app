# ios-appsflyer-mopicker-sample-app

<img src="https://github.com/AppsFlyerSDK/appsflyer-apple-swift-app/blob/master/RepositoryAssets/6.5-inch%20Screenshot%202.jpg?raw=true" alt="image1" width="200" height="432">  <img src="https://github.com/AppsFlyerSDK/appsflyer-apple-swift-app/blob/master/RepositoryAssets/6.5-inch%20Screenshot%203.jpg?raw=true" alt="image2" width="200" height="432">  <img src="https://github.com/AppsFlyerSDK/appsflyer-apple-swift-app/blob/master/RepositoryAssets/6.5-inch%20Screenshot%204.jpg?raw=true" alt="image3" width="200" height="432">

Mopicker is a sample app, that has been written in native Swift programming language using SwiftUI and Combine frameworks in order to demonstrate the AppsflyerSDK implementation. 

# Launching the project

#### To launch the project in limited functionality mode with AppsFlyerSDK, please, follow next steps: 

1) Clone the repository or download it as a .zip archive;
2) Go to the cloned or unarchived project directory using terminal and run `pod install` command. If this command is unavailable to you, please install Cocoapods dependency manager (https://cocoapods.org/).
3) To be able to test AppsFlyer SDK, open the `mopicker-sample-app.xcworkspace` file, go to `Assets/Info.plist` and add your __af_dev_key__ and __af_app_id__ (Appendix 1).

**_Appendix 1_**


<img src="https://github.com/AppsFlyerSDK/appsflyer-apple-swift-app/blob/master/RepositoryAssets/Screenshot%202020-06-01%20at%2015.18.25.png?raw=true" alt="image1">
 
#### In order to launch the project in full-mode with Firebase authentification and Google Sign-in features, please do the following after completing first three steps: 

4) Create projects in Google and Firebase dashboards to see the data flow in consoles, after launch of full-mode application  (https://firebase.google.com/, https://developers.google.com/identity/sign-in/ios); 
5) Open the __Info.plist__ file and add your __google_client_id__ (Appendix 1) and add your __REVERSED_CLIENT_ID__ to the url-scheme as it is described in (https://developers.google.com/identity/sign-in/ios/sdk) in order to activate **Google Sign-In**; 
6) To enable **Firebase** in the app you should remove existing `GoogleService-Info.plist` file in `Assets` folder and add your own file to the project navigator, which you will recieve after creating a project in Firebase Console (https://console.firebase.google.com/)(Appendix 2);


**_Appendix 2_**

<img src="https://github.com/AppsFlyerSDK/appsflyer-apple-swift-app/blob/master/RepositoryAssets/Screenshot%202020-06-01%20at%2015.18.56.png?raw=true" alt="image1">


7) Go to the `AppConstants.swift` file and change `var isOpenSource` property to `false`;

_**NOTE:** If you change the app to the open source and do not provide Firebase of Google Sign-in identifiers, the app will crash._
