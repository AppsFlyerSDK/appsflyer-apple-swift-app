//
//  GoogleButtonView.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 07.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct GoogleButtonView: View {
    var body: some View {
        GoogleButtonRepresentable().frame(width: 150, height: 50)
    }
}

struct GoogleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleButtonView()
    }
}

struct GoogleButtonRepresentable: UIViewRepresentable {
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleButtonRepresentable>) {
        print("update view")
    }
    
    func makeUIView(context: UIViewRepresentableContext<GoogleButtonRepresentable>) -> GIDSignInButton {
        let signInButton = GIDSignInButton()
        signInButton.colorScheme = .light
        GoogleAuthService.googleSignIn.signInButtonPressed()
        return signInButton
    }
}
