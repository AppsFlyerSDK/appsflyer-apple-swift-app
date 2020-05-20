//
//  VideoSearchModel.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 05.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Foundation

// MARK: - Welcome
class VideoSearch: Codable {
    let page, totalResults, totalPages: Int
    let results: [SearchResult]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

    init(page: Int, totalResults: Int, totalPages: Int, results: [SearchResult]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}

// MARK: - Result
class SearchResult: Codable, Identifiable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String?
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: OriginalLanguage?
    let originalTitle: String
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }

    init(popularity: Double, voteCount: Int, video: Bool, posterPath: String?, id: Int, adult: Bool, backdropPath: String?, originalLanguage: OriginalLanguage?, originalTitle: String, genreIDS: [Int], title: String, voteAverage: Double, overview: String, releaseDate: String?) {
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.posterPath = posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
}
