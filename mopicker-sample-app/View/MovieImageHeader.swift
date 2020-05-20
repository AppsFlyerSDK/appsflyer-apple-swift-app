//
//  MovieImageHeader.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 12.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI

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
                    if self.provideImageData() != nil {
                        Image(uiImage: self.provideImageData()!)
                                               .resizable()
                                               .aspectRatio(contentMode: .fill)
                                               .frame(width: geo.size.width, alignment: .top)
                                               .overlay(TextOverlay(name: self.result?.originalTitle ?? self.result?.title ?? ""), alignment: .bottom)
                    }
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
    
    private func shareVideo() {
        self.isShareSheetShown.toggle()
        let av = UIActivityViewController(activityItems: [provideImageData() ?? UIImage()], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

