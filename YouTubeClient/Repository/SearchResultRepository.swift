//
//  SearchResultRepository.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/14.
//

import Foundation

typealias SearchComplete = (Bool) -> Void

class SearchResultRepository: ObservableObject {
    
    @Published var items = [SearchResult]()
    
    func performSearch(for text: String, completion: @escaping SearchComplete) {
        let queue = DispatchQueue.global()
        let url = apiURL(searchText: text)
        var results = [SearchResult]()
        
        queue.async {
            if let data = self.performRequest(with: url) {
                results = self.parse(data: data)
            }
            
            DispatchQueue.main.async {
                self.items = results
                completion(true)
            }
        }
    }
    
    private func apiURL(searchText: String) -> URL {
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let maxResults = 50
        let APIKey = "Axxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        let urlString = "https://www.googleapis.com/youtube/v3/search?" +
                        "part=snippet&q=\(encodedText)&type=video" +
                        "&maxResults=\(maxResults)&key=\(APIKey)"
        let url = URL(string: urlString)
        return url!
    }
    
    private func performRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            return result.items
        } catch {
            print("JSON Error: \(error.localizedDescription)")
            return []
        }
    }
}
