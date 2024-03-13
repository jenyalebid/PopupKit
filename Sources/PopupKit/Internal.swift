//
//  Ineternal.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/24/24.
//

import Foundation
import UIKit


internal class PK {
    
    static func findRootViewControllerInForegroundScene() -> UIViewController? {
        guard let currentScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return nil
        }

        guard let rootViewController = currentScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return nil
        }

        return rootViewController
    }
    
    static func findTopViewController(in rootViewController: UIViewController) -> UIViewController {
        if let presented = rootViewController.presentedViewController {
            return findTopViewController(in: presented)
        }
        
        return rootViewController
    }
    
    static func findTopViewControllerInForegroundScene() -> UIViewController? {
        guard let currentScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            fatalError("No connected Scene")
        }

        guard let rootViewController = currentScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            fatalError("No root")
        }

        return findTopViewController(in: rootViewController)
    }
}

extension UIViewController {
    
    static func findTopMostViewController(base: UIViewController? = nil) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return PK.findTopViewController(in: nav)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return PK.findTopViewController(in: selected)
            }
            return PK.findTopViewController(in: tab)
        }
        if let presented = base?.presentedViewController {
            return PK.findTopViewController(in: presented)
        }
        
        if let root = UIApplication.shared.windows.first?.rootViewController {
            return PK.findTopViewController(in: root)
        }
        
        fatalError("No Base")
    }
}
