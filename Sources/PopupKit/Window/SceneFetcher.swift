//
//  SceneFetcher.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

struct SceneFetcher: UIViewControllerRepresentable {
    
    var callback: (UIWindowScene?) -> ()
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        callback(uiViewController.view.window?.windowScene)
    }
}
