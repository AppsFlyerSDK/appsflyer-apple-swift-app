//
//  UIApplication+ResignFirstResponder.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 05.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
