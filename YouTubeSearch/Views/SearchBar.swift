//
//  SearchBar.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/11.
//

import SwiftUI
import Combine

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    var searchBarStyle = UISearchBar.Style.minimal
    var autocapitalizationType = UITextAutocapitalizationType.none
    var isFirstResponder = false
    
    private let searchButtonClickedSubject = PassthroughSubject<Void, Never>()
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle  = searchBarStyle
        searchBar.autocapitalizationType = autocapitalizationType
        searchBar.placeholder = placeholder
        if isFirstResponder {
            searchBar.becomeFirstResponder()
        }
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        context.coordinator.searchBar = self
    }
    
    func onSearchBarSearchButtonClicked(perform: @escaping (() -> Void)) -> some View {
        return onReceive(searchButtonClickedSubject) {
            perform()
        }
    }
}

extension SearchBar {
    
    final class Coordinator: NSObject, UISearchBarDelegate {
        
        fileprivate var searchBar: SearchBar
        
        init(_ searchBar: SearchBar) {
            self.searchBar = searchBar
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.searchBar.text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.searchBar.searchButtonClickedSubject.send()
        }
    }
}
