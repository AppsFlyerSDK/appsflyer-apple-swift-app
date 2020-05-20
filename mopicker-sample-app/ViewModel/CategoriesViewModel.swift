//
//  CategoriesViewModel.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 13.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Combine
import Foundation

class CategoriesViewModel: ObservableObject {
    private let neworkingManager = NetworkingManager.shared
    
    var didChange = PassthroughSubject<Genres, Never>()
    @Published var genres: Genres = Genres(genres: [Genre]()) {
        didSet {
            self.didChange.send(self.genres)
        }
    }
    
    init() {
        fetchGenres()
    }
    
    private func fetchGenres() {
        let urlString = ConstantNamespaces.genresURL + ConstantNamespaces.apiV3Key
        
        neworkingManager.requestAPIData(urlString, model: Genres.self) { (genresData) in
            DispatchQueue.main.async { [weak self] in
                self?.genres = genresData
            }
        }
    }
}
