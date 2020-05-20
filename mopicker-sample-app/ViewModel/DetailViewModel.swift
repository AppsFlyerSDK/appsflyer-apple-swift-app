//
//  DetailViewModel.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 04.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Combine
import SwiftUI

final class DetailViewModel: ObservableObject {
    
    private var didChange = PassthroughSubject<Data, Never>()
    private var networkingManager = NetworkingManager.shared
    var name: String
    var id: Int {
        didSet{
            print("ID: ", self.id)
        }
    }
    
    var movieData: MovieData?  {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.fetchImageData(imageEndpoint: self?.movieData?.backdropPath ?? "")
            }
        }
    }
    
    @Published var imageData: Data = Data() {
        didSet {
            self.didChange.send(imageData)
        }
    }
    
    init(movieId: Int, name: String) {
        self.id = movieId
        self.name = name
        self.fetchMovieData(movieId: String(self.id))
    }
    
    private func fetchMovieData(movieId: String) {
        networkingManager.requestAPIData(ConstantNamespaces.movieDetails + movieId + ConstantNamespaces.movieDetailsApiKey, model: MovieData.self) { [weak self] (result) in
            self?.movieData = result
        }
    }
    
    private func fetchImageData(imageEndpoint: String) {
        networkingManager.requestImageData(ConstantNamespaces.requestW500Image + imageEndpoint) { [weak self] (imageData) in
            DispatchQueue.main.async {
                self?.imageData = imageData
            }
        }
    }
    
    
}
