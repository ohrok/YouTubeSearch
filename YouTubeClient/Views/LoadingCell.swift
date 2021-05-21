//
//  LoadingCell.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/19.
//

import SwiftUI

struct LoadingCell: View {
    
    @State var isLoading: Bool
    
    var body: some View {
        HStack {
            Text("Loading...")
                .font(.system(size: 15))
                .foregroundColor(.gray)
            ActivityIndicator(isAnimating: $isLoading, style: .medium)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct LoadingCell_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCell(isLoading: true)
    }
}
