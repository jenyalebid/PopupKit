//
//  SceneAlertModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/7/24.
//

import SwiftUI
import UIKit

struct SceneAlertModifier: ViewModifier {
    
    
    @Binding var isPresented: Bool
    let alert: SceneAlert

    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { newValue in
                if newValue {
                    presentAlert()
                }
            }
    }

    private func presentAlert() {
        guard let topViewController = findTopViewControllerInCurrentScene() else { return }
        let alertController = alert.uiAlert
        topViewController.present(alertController, animated: true) {
            self.isPresented = false
        }
    }

    private func findTopViewControllerInCurrentScene() -> UIViewController? {
        guard let currentScene = UIApplication.shared
                .connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return nil
        }

        guard let rootViewController = currentScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return nil
        }

        return findTopViewController(controller: rootViewController)
    }

    private func findTopViewController(controller: UIViewController) -> UIViewController {
        if let presented = controller.presentedViewController {
            return findTopViewController(controller: presented)
        }
        return controller
    }
}

public extension View {
    
    func sceneAlert(isPresented: Binding<Bool>, alert: SceneAlert) -> some View {
        modifier(SceneAlertModifier(isPresented: isPresented, alert: alert))
    }
}

