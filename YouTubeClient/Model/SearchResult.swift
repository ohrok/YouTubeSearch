//
//  Hoge.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/11.
//

import Foundation

struct ResultArray: Codable {
    var items = [SearchResult]()
}

struct SearchResult: Codable, Identifiable {
    var id: String
    var originalID: originalID
    var snippet: Snippet
    
    enum CodingKeys: String, CodingKey {
        case id = "etag"
        case originalID = "id"
        case snippet
    }
}

struct originalID: Codable {
    var videoId: String
}

struct Snippet: Codable {
    var title: String
    var thumbnails: Thumbnails
    var channelTitle: String
}

struct Thumbnails: Codable {
    var `default`: Thumbnail
    var medium: Thumbnail
    var high: Thumbnail
}

struct Thumbnail: Codable {
    var url: String
}
