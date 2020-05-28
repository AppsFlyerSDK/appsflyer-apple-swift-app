//
//  SwiftUIView.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 21.04.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI

struct GridView<Content, T>: View where Content: View {
    let content: (GeometryProxy, CGFloat, CGFloat, T) -> Content
    var items: [T]
    var columns: Int
    var numberOfRows: Int {
        (items.count - 1) / columns
    }
    
    init(columns: Int, items: [T], @ViewBuilder content: @escaping (GeometryProxy, CGFloat, CGFloat, T) -> Content) {
        self.columns = columns
        self.items = items
        self.content = content
    }
    
    private func elementFor(row: Int, column: Int) -> Int? {
        let index = row * self.columns + column
        return index < items.count ? index : nil
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                ForEach(0...self.numberOfRows, id: \.self) { row in
                    HStack {
                        ForEach(0..<self.columns, id: \.self) { column in
                            Group {
                                if self.elementFor(row: row, column: column) != nil {
                                    self.content(geometry, (geometry.size.width / CGFloat(self.columns)), geometry.size.height / CGFloat(self.columns) , self.items[self.elementFor(row: row, column: column)!]).frame(width: geometry.size.width / CGFloat(self.columns), height: geometry.size.height / CGFloat(self.columns))
                                } 
                            }
                        }
                    }.frame(width: geometry.size.width)
                }
            }
        }
    }
}


