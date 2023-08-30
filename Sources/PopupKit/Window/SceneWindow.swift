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
        window = UIWindow(windowScene: scene)
        
        window.rootViewController = viewController
        window.windowLevel = level
        window.backgroundColor = UIColor.clear
    }
}

fileprivate class PassThroughView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden,
               subview.alpha > 0,
               subview.isUserInteractionEnabled,
               subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}