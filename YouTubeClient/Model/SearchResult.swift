//
//  Hoge.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/11.
//

import Foundation

struct Hoge: Codable, Identifiable {
    var id = UUID()
    var title: String
    var channelTitle: String
}

struct ResultArray: Codable {
    var items: [SearchResult]
}

struct SearchResult: Codable {
    var etag: String
    var id: ID
    var snippet: Snippet
    
    struct ID: Codable {
        var videoId: String
    }

    struct Snippet: Codable {
        var title: String
        var description: String
        var thumbnails: Thumbnails
        var channelTitle: String
        
        struct Thumbnails: Codable {
            var `default`: Thumbnail
            
            struct Thumbnail: Codable {
                var url: String
            }
        }
    }
}
