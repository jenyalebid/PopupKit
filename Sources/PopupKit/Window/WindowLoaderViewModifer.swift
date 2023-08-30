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
                SceneFetcher { scene in
                    if let scene {
                        loadWindow(in: scene)
                    }
                }
            )
    }
    
    func loadWindow(in scene: UIWindowScene) {
        let contentController = UIHostingController(rootView: windowContent)
        window.load(contentController, in: scene)
    }
}

extension View {
    
    func windowLoader<WindowContent: View>(for window: SceneWindow, windowContent: WindowContent) -> some View {
        modifier(WindowLoaderViewModifer(for: window, windowContent: windowContent))
    }
}

fileprivate struct WindowPresenterViewModifer_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
        }
    }
}
