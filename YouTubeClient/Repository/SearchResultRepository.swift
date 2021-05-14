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
        let url = apiURL(searchText: text)
        print("URL: '\(url)'")
        if let jsonString = performRequest(with: url) {
            print("Received JSON string: '\(jsonString)'")
        }
        
        searchResults = videos.filter {
            $0.title.lowercased().contains(text.lowercased()) || $0.channelTitle.lowercased().contains(text.lowercased())
        }
    }
    
    private func apiURL(searchText: String) -> URL {
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let maxResults = 50
        let APIKey = "Axxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        let urlString = "https://www.googleapis.com/youtube/v3/search?" +
                        "part=snippet&q=\(encodedText)&type=video" +
                        "&maxResults=\(maxResults)&key=\(APIKey)"
        let url = URL(string: urlString)
        return url!
    }
    
    private func performRequest(with url: URL) -> String? {
        do {
            return try String(contentsOf: url, encoding: .utf8)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            return nil
        }
    }
}
