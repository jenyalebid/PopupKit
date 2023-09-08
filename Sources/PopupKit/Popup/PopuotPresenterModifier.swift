//
//  PopoutPresenterModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 9/7/23.
//

import SwiftUI

struct PopoutPresenterModifier<PopoutContent: View>: ViewModifier {
    
    var popoutContent: PopoutContent
    
    @State var topController: UIViewController?
    
    @Binding var isPresented: Bool
    @State private var trigger: Bool = false
    
    @State var rect: CGRect?
    @State var scene: UIWindowScene?

    init(isPresented: Binding<Bool>, popoutContent: PopoutContent) {
        self._isPresented = isPresented
        self.popoutContent = popoutContent
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                UIKitViewFetcher { view in
                    DispatchQueue.main.async {
                        self.scene = view.window?.windowScene
                        if let window = view.window {
                            self.rect = view.convert(view.bounds, to: window)
                        }
                    }
                }
            )
            .onChange(of: isPresented) { presented in
                presented ? present() : topController?.dismiss(animated: false)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.trigger.toggle()
                }
            }
    }
    
    func present() {
        guard let scene, let topController = UIApplication.topMostViewController(from: scene.keyWindow?.rootViewController) else {
            return
        }
        DispatchQueue.main.async {
            self.topController = topController
        }

        let hostController = UIHostingController(rootView: popoutContent)
        hostController.modalPresentationStyle = .custom
        hostController.view.backgroundColor = .clear
        topController.present(hostController, animated: false)
    }
}
