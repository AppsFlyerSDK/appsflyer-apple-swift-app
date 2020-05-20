//
//  CategoriesView.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 13.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI

struct CategoriesView: View  {
    let content: (Int) -> Void
    @ObservedObject var categories = CategoriesViewModel()
    @State var buttonState = SelectableButtonStyle()
    
    init(@ViewBuilder content: @escaping (Int) -> ()) {
        self.content = content
    }
    
    var body: some View {
        ScrollView(.horizontal, content: {
            HStack(spacing: 10) {
                ForEach(categories.genres.genres) { genre in
                    Button(action: {
                        self.buttonState.isSelected = !self.buttonState.isSelected
                        self.content(genre.id ?? 0)
                    }, label: { Text(genre.name ?? "Empty")
                    .font(.headline)
                    .foregroundColor(Color.gray)
                    .padding(5)
                    }).border(Color.gray).cornerRadius(2)
                }
                .shadow(color: Color.gray, radius: 5)
            }.frame(height: 50)
            }).padding(5)
    }
}
