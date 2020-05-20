//
//  MainViewModel.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 28.04.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//
import SwiftUI
import Combine
import SDWebImage
import RealmSwift

final class MainViewModel: ObservableObject {
    
    @Published var moviesByGenre = Array(RealmManager.shared.getDataFromDB()) {
        didSet {
            didCange.send(self)
        }
    }
    
    private unowned let networkingManager = NetworkingManager.shared
    
    var genreID: Int = 16
    var startIndex: Int { moviesByGenre.startIndex }
    var endIndex: Int { moviesByGenre.endIndex }
    private var pageToLoad: Int = 1
    private var currentlyLoading = false
    
    let didCange = PassthroughSubject<MainViewModel, Never>()
    
    init() {
        fetchListsByGenre(id: genreID)
    }
    
    @discardableResult
    private func shouldLoadMoreMovies() -> Bool {
        if currentlyLoading {
            return false
        }
        return true
    }
    
    private func loadMoreMovies() {
        if !shouldLoadMoreMovies() {
            return
        }
        currentlyLoading = true
        showGenreMovies(id: genreID)
    }
    
    
    func fetchListsByGenre(id: Int) {
        if id != self.genreID {
            self.genreID = id
            self.pageToLoad = 1
        }
        
        let url = ConstantNamespaces.moviesByGenreURL + String(genreID) + ConstantNamespaces.pageParameter + String(pageToLoad)
        networkingManager.requestAPIData(url, model: TrendVideos.self) { [weak self] (result) in
            DispatchQueue.main.async { [weak self] in
                RealmManager.shared.addData(object: result.results)
                self?.pageToLoad += 1
                self?.currentlyLoading = false
                self?.shouldLoadMoreMovies()
            }
        }
    }
    
    func showGenreMovies(id: Int) {
        self.genreID = id
        self.fetchListsByGenre(id: genreID)
        self.moviesByGenre = Array(RealmManager.shared.getDataFromDB()).filter { ($0.genreIDS).contains(genreID)}
    }
}

extension MainViewModel: RandomAccessCollection {
    subscript(position: Int) -> Result {
        return self.moviesByGenre[position]
    }
}
