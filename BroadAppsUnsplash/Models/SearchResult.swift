//
//  SearchResult.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 11.10.2022.
//

import Foundation

struct SearchResult: Decodable{
    let total: Int
    let results: [Images]
}

struct Images: Decodable {
    let id: String
    let urls: Urls
    let height: Int
    let width: Int
}


struct Urls: Decodable {
    let raw, full, regular, small, thumb: String
}

// MARK: - User

