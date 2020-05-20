//
//  MovieSearchViewModel.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 05.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI
import Combine

class MovieSearchViewModel: ObservableObject {
    
    private var networkingManager = NetworkingManager.shared
    var didChange = PassthroughSubject<MovieSearchViewModel, Never>()
    @Published var searchQuiery: String = "" {
        didSet {
            self.fetchSearchData(searchQuiery: self.searchQuiery)
        }
    }
    
    @Published var searchResult: [SearchResult]? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    init() {
        
    }
    
    private func fetchSearchData(searchQuiery: String) {
        let searchURLString =  "https://api.themoviedb.org/3/search/movie?api_key=34aa242becb78580330dbb426b07379a&query=\(searchQuiery)&page=1"
        print(searchURLString)
        
        networkingManager.requestAPIData(searchURLString, model: VideoSearch.self) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.searchResult = result.results
            }
        }
    }
}



