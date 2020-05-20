//
//  GenresModel.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 12.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Foundation

// MARK: - Welcome
class Genres: Codable {
    let genres: [Genre]

    init(genres: [Genre]) {
        self.genres = genres
    }
}
