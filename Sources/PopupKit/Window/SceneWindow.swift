//
//  SceneWindow.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/26/23.
//

import UIKit
import SwiftUI

class SceneWindow {

    private var window: UIWindow!
    
    var level: UIWindow.Level
    
    init(level: UIWindow.Level) {
        self.level = level
    }
    
    func load(_ viewController: UIViewController, in scene: UIWindowScene) {
        if window == nil { create(with: viewController, in: scene) }
    }
}

extension SceneWindow {
    
    func makeKeyAndVisible() {
        window?.makeKeyAndVisible()
    }
    
    func makeKey() {
        window?.makeKey()
    }
    
    func show() {
        window?.isHidden = false
    }
    
    func hide() {
        window?.isHidden = true
    }
    
    func destroy() {
        hide()
        window.rootViewController?.removeAllChildren()
        window = nil
    }
}

private extension SceneWindow {
    
    func create(with viewController: UIViewController, in scene: UIWindowScene) {
        window = PassThroughWindow(windowScene: scene)
        window.rootViewController = viewController
        
        window.windowLevel = level
        window.backgroundColor = UIColor.clear
    }
}
