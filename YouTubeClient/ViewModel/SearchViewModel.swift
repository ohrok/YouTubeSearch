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
    @Published var isLoading = false
    @Published var isNoResults = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        searchResultRepository.$items
            .assign(to: \.searchResults, on: self)
            .store(in: &cancellables)
        
        searchResultRepository.$isLoading
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
        
        searchResultRepository.$isNoResults
            .assign(to: \.isNoResults, on: self)
            .store(in: &cancellables)
    }
    
    func performSearch(for text: String, completion: @escaping SearchComplete) {
        searchResultRepository.performSearch(for: text, completion: completion)
    }
}
