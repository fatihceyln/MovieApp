//
//  GenreModel.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 8.02.2022.
//

import Foundation

struct GenreModel: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Hashable {
    let id: Int
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
