//
//  SearchResultRepository.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/14.
//

import Foundation
import Combine

typealias SearchComplete = (Bool) -> Void

class SearchResultRepository: ObservableObject {
    
    @Published var items = [SearchResult]()
    
    private var cancellables = Set<AnyCancellable>()
    
    func performSearch(for text: String, completion: @escaping SearchComplete) {
        items = []
        let url = apiURL(searchText: text)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ResultArray.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { _ in
                DispatchQueue.main.async {
                    completion(true)
                }
            }, receiveValue: { resultArray in
                DispatchQueue.main.async {
                    self.items = resultArray.items
                }
            })
            .store(in: &cancellables)
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
}
