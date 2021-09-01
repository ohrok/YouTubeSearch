//
//  WebView.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var loadUrl:String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: loadUrl)!))
    }
}
