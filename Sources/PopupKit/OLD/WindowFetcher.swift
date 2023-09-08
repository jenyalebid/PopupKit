//
//  WindowFetcher.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/26/23.
//

import SwiftUI

struct WindowFetcher: UIViewControllerRepresentable {
    
    var callback: (UIWindow?) -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        callback(uiViewController.view.window)
    }
}

struct WindowFetcherModifier: ViewModifier {
    
    var window: (UIWindow?) -> Void
    
    func body(content: Content) -> some View {
        content
            .background(WindowFetcher(callback: window))
    }
}

public extension View {
    
    func windowFetcher(window: @escaping (UIWindow?) -> Void) -> some View {
        modifier(WindowFetcherModifier(window: window))
    }
}
