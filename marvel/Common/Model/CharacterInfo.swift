//
//  CharacterData.swift
//  marvel
//
//  Created by David Garcia on 20/09/2020.
//

import Foundation

// MARK: - DataInfo
struct CharacterInfo: Codable {
    var data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    var offset, limit, total: Int
    var results: [CharacterData]
}

// MARK: - Result
struct CharacterData: Codable {
    var id: Int
    var name, resultDescription, modified: String
    var thumbnail: Thumbnail
    var resourceURI: String
    var comics, series: Comics
    var stories: Stories
    var events: Comics
    var urls: [URLElement]

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
struct Comics: Codable {
    var available: Int
    var collectionURI: String
    var items: [ComicsItem]
    var returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    var resourceURI: String
    var name: String
}

// MARK: - Stories
struct Stories: Codable {
    var available: Int
    var collectionURI: String
    var items: [StoriesItem]
    var returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    var resourceURI: String
    var name: String
    var type: ItemType
}

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case letters = "letters"
    case pinup = "pinup"
    case promo = "promo"
    case recap = "recap"
    case textArticle = "text article"
    case textFeature = "text feature"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    var path: String
    var thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
    case png = "png"
}

// MARK: - URLElement
struct URLElement: Codable {
    var type: URLType
    var url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
