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
        HStack {
            KFImage(URL(string: searchResult.snippet.thumbnails.default.url))
                .resizable()
                .font(.system(size: 10, weight: .thin, design: .default))
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
            VStack(alignment: .leading, spacing: 8) {
                Text(searchResult.snippet.title)
                    .font(.system(size: 18))
                Text(searchResult.snippet.channelTitle)
                    .font(.system(size: 15))
            }
        }
    }
}
