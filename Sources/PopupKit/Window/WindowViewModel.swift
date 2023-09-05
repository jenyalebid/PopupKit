//
//  WindowViewModel.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI
import UIKit

class WindowViewModel<Content: View>: ObservableObject {
    
    @Published var isWindowPresented: Bool
    @Published var isContentPresented: Bool
    
    @Published var contentSize: CGSize = .zero
    
    var mainController = UIViewController()
    var contentController: UIHostingController<Content>?
    
    var window: SceneWindow
    
    init(level: UIWindow.Level, isPresented: Bool) {
        window = SceneWindow(level: level)
        isWindowPresented = isPresented
        isContentPresented = isPresented
    }
    
    func manageWindowVisibility(isPresented: Bool) {
        isPresented ? window.makeKeyAndVisible() : window.destroy()
    }
    
    func manageContentPresentation(isPresented: Bool) {
        if isPresented {
            isWindowPresented = true
        }
        else {
            withAnimation {
                isContentPresented = isPresented
            }
        }
    }
}
