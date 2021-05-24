//
//  SearchResultCell.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/12.
//

import SwiftUI
import Kingfisher

struct SearchResultCell: View {
    
    let searchResult: SearchResult
        
    var body: some View {
        ZStack {
            NavigationLink(destination: WebView(loadUrl: "https://www.youtube.com/watch?v=" + searchResult.originalID.videoId)) {
                EmptyView()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                KFImage
                    .url(URL(string: searchResult.snippet.thumbnails.high.url))
                    .placeholder {
                        Image("Placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.gray)
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Text(searchResult.snippet.title)
                    .font(.system(size: 18))
                Text(searchResult.snippet.channelTitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
        }
    }
}
