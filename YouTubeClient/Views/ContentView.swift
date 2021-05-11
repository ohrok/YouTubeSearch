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
        for i in 0..<50 {
            let video = "video\(i + 1)"
            videos.append(video)
        }
        return videos
    }()
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search Spots")
                .onSearchBarSearchButtonClicked {
                    print("The search text is: '\(searchText)'")
                }
            List {
                ForEach(videos.filter {
                    self.searchText.isEmpty || $0.lowercased().contains(self.searchText.lowercased())
                }, id: \.self) { video in
                    Text(video)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
