//
//  AppWindow.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/23/23.
//

import SwiftUI

public struct AppWindow<Content: View> {
    
    private var manager = WindowOverlayManager<Content>()
    
    var content: Content
    
    public init(_ content: Content) {
        self.content = content
    }
    
    public func present() {
        manager.show(content)
    }
    
    public func dismiss() {
        manager.dismissCurrentOverlayIfPresent()
    }
}
