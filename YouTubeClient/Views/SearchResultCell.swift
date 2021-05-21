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
        VStack(alignment: .leading, spacing: 8) {
            KFImage(URL(string: searchResult.snippet.thumbnails.high.url))
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
