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
    
    @Published var resultArray = ResultArray()
    @Published var isLoading = false
    @Published var isNoResults = false
    
    private var cancellable: AnyCancellable?
    
    func performSearch(for text: String, completion: @escaping SearchComplete) {
        cancellable?.cancel()
        isLoading = true
        isNoResults = false
        let url = apiURL(searchText: text)
        var success = false
        
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                success = true
                return element.data
            }
            .decode(type: ResultArray.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
                completion(success)
            }, receiveValue: { resultArray in
                self.resultArray = resultArray
                self.isNoResults = self.resultArray.items.count == 0
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
