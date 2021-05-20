//
//  SearchViewModel.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/14.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var searchResultRepository = SearchResultRepository()
    @Published var searchResults = [SearchResult]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        searchResultRepository.$items
            .assign(to: \.searchResults, on: self)
            .store(in: &cancellables)
    }
    
    func performSearch(for text: String, completion: @escaping SearchComplete) {
        searchResultRepository.performSearch(for: text, completion: completion)
    }
}
