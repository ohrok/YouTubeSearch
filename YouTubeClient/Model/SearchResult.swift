//
//  SearchResult.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/11.
//

import Foundation

struct SearchResult: Codable, Identifiable {
    var id = UUID()
    var title: String
    var channelTitle: String
}
