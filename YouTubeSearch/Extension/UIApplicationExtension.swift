//
//  UIApplicationExtension.swift
//  YouTubeClient
//
//  Created by 大井裕貴 on 2021/05/11.
//

import UIKit

extension UIApplication {
    
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
