//
//  File.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 23.03.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Foundation

struct ConstantNamespaces {
    //api v3 key
    static let apiV3Key: String = "34aa242becb78580330dbb426b07379a"
    static let moviesByGenreURL: String = "https://api.themoviedb.org/3/discover/movie?api_key=34aa242becb78580330dbb426b07379a&with_genres="
    static let pageParameter: String = "&page="
    //api v4 key
    static let apiV4Key: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNGFhMjQyYmVjYjc4NTgwMzMwZGJiNDI2YjA3Mzc5YSIsInN1YiI6IjVlNzhjNjI3YTA1NWVmMDAxODJmZjU1NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.897od1Td0NOux5MSKMZWcYzg19ktMix3jGzPB_1drLU"
    
    static let requestW500Image: String = "https://image.tmdb.org/t/p/w500/"
    static let requestOriginalImage: String = "https://image.tmdb.org/t/p/original/"
    static let genresURL: String = "https://api.themoviedb.org/3/genre/movie/list?api_key="
    static let movieDetails: String = "https://api.themoviedb.org/3/movie/"
    static let movieDetailsApiKey: String = "?api_key=\(ConstantNamespaces.apiV3Key)&language=en-US"
    static let movieSearchQuiery: String = "https://api.themoviedb.org/3/search/movie?api_key=<<api_key>>&language=en-US&page=1&include_adult=false"
}


struct ColorConstants {
    static let mainBackgroundColor: String = "eef5ed"
}
