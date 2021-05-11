//
//  ContentView.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/08.
//

import SwiftUI

struct ContentView: View {
    
    private let videos: [String] = {
        var videos: [String] = []
        for i in 0..<1000 {
            let video = "video\(i + 1)"
            videos.append(video)
        }
        return videos
    }()
    
    @State private var searchedVideos: [String] = []
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search Spots")
                .onSearchBarSearchButtonClicked {
                    searchedVideos = videos.filter {
                        $0.lowercased().contains(self.searchText.lowercased())
                    }
                    UIApplication.shared.closeKeyboard()
                }
            List {
                ForEach(searchedVideos, id: \.self) { video in
                    Text(video)
                }
                if searchedVideos.count == 0 {
                    Text("Nothing Found")
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
