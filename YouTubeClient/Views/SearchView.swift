//
//  SearchView.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/08.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject private var searchViewModel = SearchViewModel()
    @State private var searchResults: [SearchResult] = []
    @State private var searchText: String = ""
    @State private var isNothingFound: Bool = false
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search YouTube")
                .onSearchBarSearchButtonClicked {
                    searchViewModel.search(searchText: searchText)
                    isNothingFound = searchViewModel.searchResults.count == 0
                    UIApplication.shared.closeKeyboard()
                }
            List {
                ForEach(searchViewModel.searchResults) { searchResult in
                    SearchResultCell(searchResult: searchResult)
                }
                if isNothingFound {
                    VStack(alignment: .center) {
                        Text("Nothing Found")
                            .font(.system(size: 15))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
