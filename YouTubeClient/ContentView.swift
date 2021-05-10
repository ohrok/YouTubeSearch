//
//  ContentView.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/08.
//

import SwiftUI

struct ContentView: View {
    
    let videos: [String] = {
        var videos: [String] = []
        for i in 0..<50 {
            let video = "video\(i + 1)"
            videos.append(video)
        }
        return videos
    }()
    
    var body: some View {
        List {
            ForEach(0..<videos.count) { index in
                Text(videos[index])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
