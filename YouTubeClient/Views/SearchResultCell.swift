//
//  SearchResultCell.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/12.
//

import SwiftUI

struct SearchResultCell: View {
    
    let searchResult: Hoge
        
    var body: some View {
        HStack {
            Image(systemName: "square")
                .resizable()
                .font(.system(size: 10, weight: .thin, design: .default))
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
            VStack(alignment: .leading, spacing: 8) {
                Text(searchResult.title)
                    .font(.system(size: 18))
                Text(searchResult.channelTitle)
                    .font(.system(size: 15))
            }
        }
    }
}

struct SearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultCell(searchResult: Hoge(title: "Sample title", channelTitle: "Sample channel title"))
    }
}
