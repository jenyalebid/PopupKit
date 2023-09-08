//
//  OverlayManager.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/23/23.
//

import SwiftUI

class WindowOverlayManager<Content: View> {
    
    private var currentOverlay: OverlayUIHostingController<Content>?

    func show(_ view: Content) {
        dismissCurrentOverlayIfPresent()

        let overlayController = OverlayUIHostingController(rootView: view)
        guard let window = UIApplication.shared.keyWindow else { return }
        overlayController.view.backgroundColor = .clear
        window.addSubview(overlayController.view)
        overlayController.view.frame = window.bounds

        currentOverlay = overlayController
    }

    func dismissCurrentOverlayIfPresent() {
        currentOverlay?.view.removeFromSuperview()
        currentOverlay = nil
    }
    
    var alertWindow: UIWindow?

    func showAlert() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        
        alertWindow = UIWindow(windowScene: windowScene)
        alertWindow?.windowLevel = .alert + 1  // Make it appear above other alerts
//        alertWindow?.rootViewController = YourAlertViewController()  // Your custom alert ViewController
        alertWindow?.makeKeyAndVisible()
    }

    func hideAlert() {
        alertWindow?.isHidden = true
        alertWindow = nil
    }
}


