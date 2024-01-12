//
//  SceneSheet.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/12/24.
//

import SwiftUI

struct SceneSheet<Content: View>: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    let content: () -> Content

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            let hostingController = UIHostingController(rootView: content())
            hostingController.modalPresentationStyle = .formSheet
            UIApplication.topMostViewController(from: uiViewController)?.present(hostingController, animated: true)
//            findTopMostViewController()?.present(hostingController, animated: true)
        }
    }

//    private func findTopMostViewController(_ base: UIViewController? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return findTopMostViewController(nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            return findTopMostViewController(tab.selectedViewController)
//        }
//        if let presented = base?.presentedViewController {
//            return findTopMostViewController(presented)
//        }
//        return base
//    }
}
