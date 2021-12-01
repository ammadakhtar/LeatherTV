//
//  Show.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import Foundation

// MARK: - Shows

struct Shows: Codable {
    let data: DataClass
}

// MARK: - DataClass

struct DataClass: Codable {
    let catalog: Catalog
}

// MARK: - Catalog

struct Catalog: Codable {
    let categories: [Category]
    let typename: String

    enum CodingKeys: String, CodingKey {
        case categories
        case typename = "__typename"
    }
}

// MARK: - Category

struct Category: Codable {
    let id, title: String
    let tracks: [Track]
    let typename: String

    enum CodingKeys: String, CodingKey {
        case id, title, tracks
        case typename = "__typename"
    }
}

// MARK: - Track

struct Track: Codable {
    let id, title: String
    let titleType: TrackTitleType
    let leatherTitle: String
    let season, episode: Int
    let parent: Parent?
    let logoContent, backgroundContent: Content
    let seasons: [Season]?
    let typename: TrackTypename

    enum CodingKeys: String, CodingKey {
        case id, title, titleType, leatherTitle, season, episode, parent, logoContent, backgroundContent, seasons
        case typename = "__typename"
    }
}

// MARK: - Content

struct Content: Codable {
    let sourcePath: String
    let alts: [Alt]?
    let typename: BackgroundContentTypename

    enum CodingKeys: String, CodingKey {
        case sourcePath, alts
        case typename = "__typename"
    }
}

// MARK: - Alt

struct Alt: Codable {
    let path: String
    let typename: AltTypename

    enum CodingKeys: String, CodingKey {
        case path
        case typename = "__typename"
    }
}

enum AltTypename: String, Codable {
    case alt = "Alt"
}

enum BackgroundContentTypename: String, Codable {
    case content = "Content"
}

// MARK: - Parent

struct Parent: Codable {
    let title, leatherTitle: String
    let titleType: ParentTitleType
    let seasons: [Season]
    let typename: TrackTypename

    enum CodingKeys: String, CodingKey {
        case title, leatherTitle, titleType, seasons
        case typename = "__typename"
    }
}

// MARK: - Season

struct Season: Codable {
    let number: Int
    let episodes: [Episode]
    let typename: SeasonTypename

    enum CodingKeys: String, CodingKey {
        case number, episodes
        case typename = "__typename"
    }
}

// MARK: - Episode

struct Episode: Codable {
    let number: Int
    let typename: EpisodeTypename

    enum CodingKeys: String, CodingKey {
        case number
        case typename = "__typename"
    }
}

enum EpisodeTypename: String, Codable {
    case episode = "Episode"
}

enum SeasonTypename: String, Codable {
    case season = "Season"
}

enum ParentTitleType: String, Codable {
    case tvMiniSeries = "tvMiniSeries"
    case tvSeries = "tvSeries"
}

enum TrackTypename: String, Codable {
    case track = "Track"
}

enum TrackTitleType: String, Codable {
    case movie = "movie"
    case tvEpisode = "tvEpisode"
}
