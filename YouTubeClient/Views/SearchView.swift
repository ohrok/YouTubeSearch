//
//  SearchView.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/08.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject private var searchViewModel = SearchViewModel()
    @State private var searchText: String = ""
    @State private var isNoResults: Bool = false
    @State private var isLoading: Bool = false
    @State private var isShowingAlert: Bool = false
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search YouTube")
                .onSearchBarSearchButtonClicked {
                    UIApplication.shared.closeKeyboard()
                    isLoading = true
                    searchViewModel.performSearch(for: searchText, completion: { success in
                        if success {
                            isNoResults = searchViewModel.searchResults.count == 0
                        } else {
                            isShowingAlert = true
                        }
                        isLoading = false
                    })
                }
            List {
                ForEach(searchViewModel.searchResults) { searchResult in
                    SearchResultCell(searchResult: searchResult)
                }
                if isLoading {
                    LoadingCell(isLoading: isLoading)
                } else if isNoResults {
                    Text("Nothing Found")
                        .font(.system(size: 15))
                        .foregroundColor(Color("Loading"))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Whoops..."),
                message: Text("There was an error accessing the YouTube." + " Please try again."),
                dismissButton: .cancel(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
