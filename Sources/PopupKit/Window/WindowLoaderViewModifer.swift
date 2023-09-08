//
//  WindowLoaderViewModifer.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

fileprivate struct WindowLoaderViewModifer<WindowContent: View>: ViewModifier {

    var window: SceneWindow
    var windowContent: WindowContent
        
    init(for window: SceneWindow, windowContent: WindowContent) {
        self.window = window
        self.windowContent = windowContent
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                UIKitViewFetcher { view in
                    if let scene = view.window?.windowScene {
                        load(in: scene)
                    }
                }
            )
    }
    
    func load(in scene: UIWindowScene) {
        let controller = UIHostingController(rootView: windowContent)
        controller.view.backgroundColor = .clear
        window.load(controller, in: scene)
    }
}

extension View {
    func windowLoader<WindowContent: View>(for window: SceneWindow, windowContent: WindowContent) -> some View {
        modifier(WindowLoaderViewModifer(for: window, windowContent: windowContent))
    }
}
