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
    
    func resize(to size: CGSize) {
        let orgin = position(for: size, with: .center)
//        window.rootViewController?.view.frame = CGRect(origin: orgin, size: size)
//        window.frame = CGRect(origin: orgin, size: size)
    }
}

extension SceneWindow {
    
    func align(to alignment: Alignment) {
        guard let sceneSize = window.windowScene?.coordinateSpace.bounds.size else {
            return
        }
        let windowSize = window.frame.size
        
        var newOrigin = CGPoint(x: 0, y: 0)
        switch alignment {
        case .center:
            newOrigin.x = (sceneSize.width - windowSize.width) / 2.0
            newOrigin.y = (sceneSize.height - windowSize.height) / 2.0
        case .leading:
            newOrigin.x = 0
            newOrigin.y = (sceneSize.height - windowSize.height) / 2.0
        case .trailing:
            newOrigin.x = sceneSize.width - windowSize.width
            newOrigin.y = (sceneSize.height - windowSize.height) / 2.0
        case .top:
            newOrigin.x = (sceneSize.width - windowSize.width) / 2.0
            newOrigin.y = 0
        case .bottom:
            newOrigin.x = (sceneSize.width - windowSize.width) / 2.0
            newOrigin.y = sceneSize.height - windowSize.height
        case .topLeading:
            newOrigin.x = 0
            newOrigin.y = 0
        case .topTrailing:
            newOrigin.x = sceneSize.width - windowSize.width
            newOrigin.y = 0
        case .bottomLeading:
            newOrigin.x = 0
            newOrigin.y = sceneSize.height - windowSize.height
        case .bottomTrailing:
            newOrigin.x = sceneSize.width - windowSize.width
            newOrigin.y = sceneSize.height - windowSize.height
        default:
            break
        }
        
        window.frame = CGRect(origin: newOrigin, size: windowSize)
    }
    
    func position(for size: CGSize, with alignment: Alignment) -> CGPoint {
        var position = CGPoint.zero
        let sceneSize = window.windowScene?.coordinateSpace.bounds.size ?? CGSize.zero
        let safeAreaInsets = window.rootViewController!.view.safeAreaInsets
        
        let statusBarHeight = window.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
        let isStatusBarHidden = window.windowScene?.statusBarManager?.isStatusBarHidden ?? false
        let statusBarAdjustment: CGFloat = isStatusBarHidden ? .zero : statusBarHeight
        print("WINDOW FRAME: \(window.frame.size)")
        print("CONTENT FRAME: \(size)")

        switch alignment {
        case .center:
            position.x = (sceneSize.width - size.width) / 2.0
            position.y = (sceneSize.height - size.height) / 2.0
        case .leading:
            position.x = safeAreaInsets.left
            position.y = (sceneSize.height - size.height) / 2.0
        case .trailing:
            position.x = sceneSize.width - size.width - safeAreaInsets.right
            position.y = (sceneSize.height - size.height) / 2.0
        case .top:
            position.x = (sceneSize.width - size.width) / 2.0
            position.y = isStatusBarHidden ? safeAreaInsets.top : (safeAreaInsets.top + statusBarHeight)
        case .bottom:
            position.x = (sceneSize.width - size.width) / 2.0
            position.y = sceneSize.height - size.height - safeAreaInsets.bottom
        case .topLeading:
            position.x = safeAreaInsets.left
            position.y = isStatusBarHidden ? safeAreaInsets.top : (safeAreaInsets.top + statusBarHeight)
        case .topTrailing:
            position.x = sceneSize.width - size.width - safeAreaInsets.right
            position.y = isStatusBarHidden ? safeAreaInsets.top : (safeAreaInsets.top + statusBarHeight)
        case .bottomLeading:
            position.x = safeAreaInsets.left
            position.y = sceneSize.height - size.height - safeAreaInsets.bottom
        case .bottomTrailing:
            position.x = sceneSize.width - size.width - safeAreaInsets.right
            position.y = sceneSize.height - size.height - safeAreaInsets.bottom
        default:
            break
        }
        
        return position
    }
}

private extension SceneWindow {
    
    func create(with viewController: UIViewController, in scene: UIWindowScene) {
        window = PassThroughWindow(windowScene: scene)
        window.rootViewController = viewController
        
        window.windowLevel = level
        window.backgroundColor = UIColor.clear
//        window.layer.masksToBounds = true
    }
}

class PassView: UIView {}

//class PassTroughWindow: UIWindow {
//
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let hitView = super.hitTest(point, with: event)
//        if hitView!.isKind(of: PassView.self) {
//            return nil
//        }
//  
//        return hitView
//    }
//}

class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self.rootViewController?.view ? nil : view
    }
}

//class PassThroughWindow: UIWindow {
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        guard let rootView = self.rootViewController?.view else {
//            return nil
//        }
//
//        let convertedPoint = self.convert(point, to: rootView)
//
//        if rootView.bounds.contains(convertedPoint) {
//            return super.hitTest(point, with: event)
//        } else {
//            return nil
//        }
//    }
//}

class PassThroughView: UIView {
    
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

class WindowRootController: UIViewController {
    
    @objc override var prefersStatusBarHidden: Bool {
        false
    }
}
