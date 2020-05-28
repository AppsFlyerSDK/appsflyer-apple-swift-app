//
//  MovieDetailView.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 04.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
 
    var body: some View {
        MovieImageHeader(data: viewModel.imageData, result: viewModel.movieData)
    }
}


struct MovieDescriptionView: View {
    var movieDescription: MovieData?
    
    init(movieDescription: MovieData?) {
        self.movieDescription = movieDescription
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: nil) {
            HStack(alignment: .center, spacing: 5) {
                Text("\(movieDescription?.runtime ?? 0) min")
                Divider().frame(width:1, height: 20).background(Color.black)
                Text(movieDescription?.releaseDate ?? "N/a")
                Divider().frame(width:1, height: 20).background(Color.black)
                Text(String(format: "Rating: %.2f / 10.0", movieDescription?.voteAverage ?? 0))
            }
            Divider().padding(.horizontal, 15)
            Text(movieDescription?.overview ?? "N/a")
                .font(.system(size: 14, weight: .light, design: .rounded))
                .padding(5)
                .multilineTextAlignment(.leading)
            Divider().padding(.horizontal, 15)
        }.navigationBarTitle(movieDescription?.title ?? "")
    }
}
