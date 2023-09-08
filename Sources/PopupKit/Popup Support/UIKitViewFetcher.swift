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

//    var callback: (UIWindowScene?) -> ()
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        let viewController = UIViewController()
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        callback(uiViewController.view.window?.windowScene)
//    }
