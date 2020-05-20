//
//  GridCell.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 22.04.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct GridCell: View {
    var trendVideoResult: Result
    let options = SDWebImageOptions.scaleDownLargeImages
    
    init(result: Result) {
        self.trendVideoResult = result
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            Spacer()
            Group {
                WebImage(url: buildImageURLPath(), options: options, context: nil)
                    .resizable()
                    .frame(maxWidth: 300, maxHeight: 450)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                    .clipped()

            }
            HStack {
                Spacer()
                Text(trendVideoResult.title)
                .aspectRatio(contentMode: .fit)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.black)
                Spacer()
            }
            
            
            HStack {
                Spacer()
                Image("calendar")
                    .resizable()
                    .frame(width: 15, height: 15, alignment: .leading)
                Text(trendVideoResult.releaseDate)
                    .foregroundColor(Color.black)
                Spacer()
            }.frame(alignment: .topLeading)
                
        }
        .layoutPriority(1)
        .scaledToFill()
    }
    
    private func buildImageURLPath() -> URL {
        let urlString = "\(ConstantNamespaces.requestW500Image + (self.trendVideoResult.posterPath))"
        guard let imageURL = URL(string: urlString) else { return URL(string: "")!}
        return imageURL
    }
}

struct GridCell_Previews: PreviewProvider {
    
    static var previews: some View {
        Text("Hello")
    }
}

struct TextOverlay: View {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        VStack {
            Text(name).background(Color.clear).foregroundColor(Color.white).padding(.bottom, 3).multilineTextAlignment(.center)
        }
    }
}
