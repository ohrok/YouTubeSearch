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
            let video = SearchResult(name: "video\(i + 1)", channelName: channelNameExamples.randomElement() ?? "")
            videos.append(video)
        }
        return videos
    }()
    
    @State private var searchResults: [SearchResult] = []
    @State private var searchText: String = ""
    @State private var isNothingFound: Bool = false
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search Spots")
                .onSearchBarSearchButtonClicked {
                    searchResults = videos.filter {
                        $0.name.lowercased().contains(self.searchText.lowercased()) || $0.channelName.lowercased().contains(self.searchText.lowercased()) 
                    }
                    if searchResults.count == 0 {
                        isNothingFound = true
                    }
                    UIApplication.shared.closeKeyboard()
                }
            List {
                ForEach(searchResults) { result in
                    VStack(alignment: .leading) {
                        Text(result.name).bold().foregroundColor(.red)
                        Text(result.channelName)
                    }
                }
                if isNothingFound {
                    VStack(alignment: .center) {
                        Text("Nothing Found").frame(maxWidth: .infinity, alignment: .center)
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
