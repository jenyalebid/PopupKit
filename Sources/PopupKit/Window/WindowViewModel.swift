//
//  WindowViewModel.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

class WindowViewModel: ObservableObject {
    
    @Published var isWindowPresented: Bool
    @Published var isContentPresented: Bool

    var window: SceneWindow
    
    init(level: UIWindow.Level, isPresented: Bool) {
        window = SceneWindow(level: level)
        isWindowPresented = isPresented
        isContentPresented = isPresented
    }
}
