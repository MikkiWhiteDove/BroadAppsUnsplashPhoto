//
//  DescriptionItem.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 11.10.2022.
//

import Foundation

struct ItemDescription: Decodable {
    let id: String
    let user: User
    let createdAt: String
    let location: Location
    let downloads: Int
    let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case id, location, downloads, urls, user
        case createdAt = "created_at"
    }
}

struct Location: Codable{
    let country: String?
}

struct User: Decodable {
    let name: String
}
