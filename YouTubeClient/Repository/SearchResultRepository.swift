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
    
    private var cancellable: AnyCancellable?
    
    func performSearch(for text: String, completion: @escaping SearchComplete) {
        cancellable?.cancel()
        items = []
        let url = apiURL(searchText: text)
        
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: ResultArray.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                completion(true)
            }, receiveValue: { resultArray in
                self.items = resultArray.items
            })
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
