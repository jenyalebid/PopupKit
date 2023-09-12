//
//  UIKitFetcher.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

struct UIKitViewFetcher: UIViewRepresentable {
    
    var callback: (UIView) -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        callback(uiView)
    }
}

struct UIKitViewFetcherModifier: ViewModifier {
    
    var callback: (UIView) -> Void
    
    @State private var viewUpdateTrigger = false
    
    func body(content: Content) -> some View {
        content
            .background(
                UIKitViewFetcher { view in
                    callback(view)
                }
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.viewUpdateTrigger.toggle()
                }
            }
    }
}

extension View {
    
    func uiViewFetcher(_ uiView: @escaping (UIView) -> Void) -> some View {
        modifier(UIKitViewFetcherModifier(callback: uiView))
    }
}
