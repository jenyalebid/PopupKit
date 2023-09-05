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
    @Binding var size: CGSize
        
    init(for window: SceneWindow, windowContent: WindowContent, size: Binding<CGSize>) {
        self.window = window
        self.windowContent = windowContent
        self._size = size
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                SceneFetcher { scene in
                    if let scene {
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
    func windowLoader<WindowContent: View>(for window: SceneWindow, windowContent: WindowContent, size: Binding<CGSize>) -> some View {
        modifier(WindowLoaderViewModifer(for: window, windowContent: windowContent, size: size))
    }
}
