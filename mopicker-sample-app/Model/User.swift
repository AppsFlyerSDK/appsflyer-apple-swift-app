//
//  User.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 30.04.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Foundation


struct User {
    var uid: String
    var email: String
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
