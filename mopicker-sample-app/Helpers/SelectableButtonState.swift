//
//  SelectableButtonState.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 13.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI

struct SelectableButtonStyle: ButtonStyle {

    var isSelected = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 60.0, height: 60.0, alignment: .center)
            .padding()
            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: isSelected ? 16.0 : 0.0))
            .overlay(RoundedRectangle(cornerRadius: isSelected ? 16.0 : 0.0).stroke(lineWidth: isSelected ? 2.0 : 0.0).foregroundColor(Color.pink))
            .animation(.linear)
    }
}
