//
//  MovieImageHeader.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 12.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieImageHeader: View {
    
    var imageData: Data
    var result: MovieData?
    @State var isShareSheetShown = false
    
    init(data: Data, result: MovieData?) {
        self.imageData = data
        self.result = result
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                Group {
                    WebImage(url: self.getImageURL(imageURLString: self.result?.backdropPath))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, alignment: .top)
                    .overlay(TextOverlay(name: self.result?.originalTitle ?? self.result?.title ?? ""), alignment: .bottom)
                }
                MovieDescriptionView(movieDescription: self.result)
            }.frame(alignment: .top)
        }
        .navigationBarItems(trailing: Button(action:  {
            DispatchQueue.main.async {
                self.shareVideo()
            }
        }
            , label: {
                Image(systemName: "square.and.arrow.up").resizable().scaledToFit().frame(width: 20, height: 20)
        }))
    }
    
    private func provideImageData() -> UIImage? {
        if let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    private func getImageURL(imageURLString: String?) -> URL? {
        guard let imageURL = URL(string: ConstantNamespaces.requestW500Image + (imageURLString ?? "")) else { return nil }
        return imageURL
    }
    
    private func shareVideo() {
        self.isShareSheetShown.toggle()
                let av = UIActivityViewController(activityItems: ["Check out \(result?.title ?? "") movie, that I have found using Mopicker app.", provideImageData() ?? UIImage()], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

