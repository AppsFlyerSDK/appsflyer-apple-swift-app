//
//  TrendsDataModel.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 28.04.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Foundation
import RealmSwift


@objcMembers class TrendVideos: Object, Codable, Identifiable {
    dynamic var id = UUID().uuidString
    let results = RealmSwift.List<Result>()
    dynamic var page: Int = 0
    dynamic var totalPages: Int = 0
    dynamic var totalResults: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try (container.decodeIfPresent(Int.self, forKey: .page) ?? 0)
        totalPages = try (container.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0)
        totalResults = try (container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0)
        let resultsList = try (container.decodeIfPresent([Result].self, forKey: .results) ?? [Result]())
        results.append(objectsIn: resultsList)
    }
    
    required init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Result
@objcMembers class Result: Object, Codable, Identifiable {
    dynamic var id: Int = 0
    dynamic var video: Bool = false
    dynamic var voteCount: Int = 0
    dynamic var voteAverage: Double = 0
    dynamic var title: String = ""
    dynamic var releaseDate: String = ""
    dynamic var originalLanguage = OriginalLanguage.en.rawValue
    dynamic var originalTitle: String = ""
    //Check if this one stored to DB
    dynamic var genreIDS = List<Int>()
    dynamic var backdropPath: String = ""
    dynamic var adult: Bool = false
    dynamic var overview: String = ""
    dynamic var posterPath: String = ""
    dynamic var popularity: Double = 0
    dynamic var mediaType = MediaType.movie.rawValue
    dynamic var originalName: String = ""
    dynamic var firstAirDate: String = ""
    dynamic var name = ""
    dynamic var originCountry = List<String>()
    
    
    // Need to modify getters and setters for enum objects to use them as Realm objects
    var mediaTypes: MediaType {
        get { return MediaType(rawValue: mediaType)! }
        set { mediaType = newValue.rawValue }
    }
    
    var languages: OriginalLanguage {
        get { return OriginalLanguage(rawValue: originalLanguage)! }
        set { originalLanguage = newValue.rawValue }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
        case originalName = "original_name"
        case name
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try (container.decodeIfPresent(Int.self, forKey: .id) ?? 0)
        video = try (container.decodeIfPresent(Bool.self, forKey: .video) ?? false)
        voteCount = try (container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0)
        voteAverage = try (container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0)
        title = try (container.decodeIfPresent(String.self, forKey: .title) ?? "")
        releaseDate = try (container.decodeIfPresent(String.self, forKey: .releaseDate) ?? "")
        originalLanguage = try (container.decodeIfPresent(OriginalLanguage.self, forKey: .originalLanguage) ?? OriginalLanguage.en).rawValue
        originalTitle = try (container.decodeIfPresent(String.self, forKey: .originalTitle) ?? "")
        genreIDS = try (container.decodeIfPresent(List<Int>.self, forKey: .genreIDS) ?? List<Int>())
        backdropPath = try (container.decodeIfPresent(String.self, forKey: .backdropPath) ?? "")
        adult = try (container.decodeIfPresent(Bool.self, forKey: .adult) ?? false)
        overview = try (container.decodeIfPresent(String.self, forKey: .overview) ?? "")
        posterPath = try (container.decodeIfPresent(String.self, forKey: .posterPath) ?? "")
        popularity = try (container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0)
        mediaType = try (container.decodeIfPresent(MediaType.self, forKey: .mediaType) ?? MediaType.movie).rawValue
        originalName = try (container.decodeIfPresent(String.self, forKey: .originalName) ?? "")
        firstAirDate = try (container.decodeIfPresent(String.self, forKey: .firstAirDate) ?? "")
        name = try (container.decodeIfPresent(String.self, forKey: .name) ?? "")
        originCountry = try (container.decodeIfPresent(List<String>.self, forKey: .originCountry) ?? List<String>())
        
    }
    
    required init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
    //    init(id: Int?, video: Bool?, voteCount: Int?, voteAverage: Double?, title: String?, releaseDate: String?, originalLanguage: OriginalLanguage, originalTitle: String?, genreIDS: [Int], backdropPath: String?, adult: Bool?, overview: String?, posterPath: String?, popularity: Double?, mediaType: MediaType?, originalName: String?, name: String?, firstAirDate: String?, originCountry: [String]?) {
    //        self.id = id
    //        self.video = video
    //        self.voteCount = voteCount
    //        self.voteAverage = voteAverage
    //        self.title = title
    //        self.releaseDate = releaseDate
    //        self.languages = originalLanguage
    //        self.originalTitle = originalTitle
    //        self.genreIDS = genreIDS
    //        self.backdropPath = backdropPath
    //        self.adult = adult
    //        self.overview = overview
    //        self.posterPath = posterPath
    //        self.popularity = popularity
    //        self.mediaType = mediaType
    //        self.originalName = originalName
    //        self.name = name
    //        self.firstAirDate = firstAirDate
    //        self.originCountry = originCountry
    //    }
    
}



enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case de = "de"
    case en = "en"
    case es = "es"
    case it = "it"
    case fr = "fr"
    case xx = "xx"
    case hi = "hi"
    case ru = "ru"
    case ko = "ko"
    case ja = "ja"
}
