//
//  SearchResultRepository.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/14.
//

import Foundation

class SearchResultRepository: ObservableObject {
    
    @Published var searchResults = [SearchResult]()
    
    private let videos: [SearchResult] = {
        var videos: [SearchResult] = []
        let channelNameExamples: [String] = ["iOS Academy", "TOHO animation", "SUTEHAGE"]
        for i in 0..<1000 {
            let video = SearchResult(title: "video\(i + 1)", channelTitle: channelNameExamples.randomElement() ?? "")
            videos.append(video)
        }
        return videos
    }()
    
    func performSearch(for text: String) {
        searchResults = videos.filter {
            $0.title.lowercased().contains(text.lowercased()) || $0.channelTitle.lowercased().contains(text.lowercased())
        }
    }
    
    // Call API method
}
