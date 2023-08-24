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
        window.addSubview(overlayController.view)
        overlayController.view.frame = window.bounds

        currentOverlay = overlayController
    }

    func dismissCurrentOverlayIfPresent() {
        currentOverlay?.view.removeFromSuperview()
        currentOverlay = nil
    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
       connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
