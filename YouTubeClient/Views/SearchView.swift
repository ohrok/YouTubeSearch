//
//  SearchView.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/08.
//

import SwiftUI

struct SearchView: View {
    
    private let videos: [SearchResult] = {
        var videos: [SearchResult] = []
        let channelNameExamples: [String] = ["iOS Academy", "TOHO animation", "SUTEHAGE"]
        for i in 0..<1000 {
            let video = SearchResult(title: "video\(i + 1)", channelTitle: channelNameExamples.randomElement() ?? "")
            videos.append(video)
        }
        return videos
    }()
    
    @State private var searchResults: [SearchResult] = []
    @State private var searchText: String = ""
    @State private var isNothingFound: Bool = false
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search YouTube")
                .onSearchBarSearchButtonClicked {
                    searchResults = videos.filter {
                        $0.title.lowercased().contains(self.searchText.lowercased()) || $0.channelTitle.lowercased().contains(self.searchText.lowercased()) 
                    }
                    isNothingFound = searchResults.count == 0
                    UIApplication.shared.closeKeyboard()
                }
            List {
                ForEach(searchResults) { searchResult in
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
