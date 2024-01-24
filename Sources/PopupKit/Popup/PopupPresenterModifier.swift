//
//  PopupPresenterModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 9/7/23.
//

import SwiftUI

struct PopupPresenterModifier<PopupContent: View>: ViewModifier {
    
    var popupContent: PopupContent
    
    @State var topController: UIViewController?
    @Binding var isPresented: Bool
    
    @State var rect: CGRect?
    @State var scene: UIWindowScene?

    init(isPresented: Binding<Bool>, popoutContent: PopupContent) {
        self._isPresented = isPresented
        self.popupContent = popoutContent
    }
    
    func body(content: Content) -> some View {
        content
            .uiViewFetcher { view in
                DispatchQueue.main.async {
                    self.scene = view.window?.windowScene
                    if let window = view.window {
                        self.rect = view.convert(view.bounds, to: window)
                    }
                }
            }
            .onChange(of: isPresented) { _, presented in
                presented ? present() : topController?.dismiss(animated: false)
            }
    }
    
    func present() {
        guard let scene, let topController = UIApplication.topMostViewController(from: scene.keyWindow?.rootViewController) else {
            return
        }
        DispatchQueue.main.async {
            self.topController = topController
        }
        let hostController = UIHostingController(rootView: popupContent)
        hostController.view.backgroundColor = .clear

        hostController.modalPresentationStyle = .overFullScreen
        topController.present(hostController, animated: false)
    }
}
