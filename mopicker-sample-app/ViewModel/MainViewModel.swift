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
    
    @Published var moviesByGenre = [Result]() {
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
    func shouldLoadMoreMovies(currentItem: Result) -> Bool {
        guard let lastItem = filterMoviesByGenre().last else {
            return true
        }
        
        return lastItem.id == currentItem.id
    }
    
    func loadMoreMovies(currentItem: Result) {
        if !shouldLoadMoreMovies(currentItem: currentItem) {
            return
        }
        currentlyLoading = true
        fetchListsByGenre(id: self.genreID)
    }
    
    
    func fetchListsByGenre(id: Int) {
        if id != self.genreID {
            self.genreID = id
            self.pageToLoad = 1
        }
        
        let url = ConstantNamespaces.moviesByGenreURL + String(genreID) + ConstantNamespaces.pageParameter + String(pageToLoad)
        print(url)
        networkingManager.requestAPIData(url, model: TrendVideos.self) { [weak self] (result) in
            DispatchQueue.main.async { [weak self] in
                RealmManager.shared.addData(object: result.results)
                self?.pageToLoad += 1
                self?.currentlyLoading = false
                self?.showGenreMovies(id: self?.genreID ?? 0)
            }
        }
    }
    
    func showGenreMovies(id: Int) {
        genreID = id
        moviesByGenre = filterMoviesByGenre()
        
        if moviesByGenre.count == 0 {
            fetchListsByGenre(id: id)
        }
    }
    
    private func filterMoviesByGenre() -> [Result] {
        return Array(RealmManager.shared.getDataFromDB()).filter { ($0.genreIDS).contains(genreID)}
    }
}

extension MainViewModel: RandomAccessCollection {
    subscript(position: Int) -> Result {
        return self.moviesByGenre[position]
    }
}
