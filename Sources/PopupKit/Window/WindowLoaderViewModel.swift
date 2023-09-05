//
//  WindowLoaderViewModel.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/31/23.
//

import UIKit
import SwiftUI

class WindowLoaderViewModel<Content: View>: ObservableObject {
    
    @Published var size: CGSize = .zero
    
    var mainController = UIViewController()
    var contentController: UIHostingController<Content>!
    
    func load(_ window: SceneWindow, in scene: UIWindowScene, for content: Content) {
        mainController = UIViewController()
        let passView = PassView(frame: scene.coordinateSpace.bounds)
        mainController.view = passView
        

        // Create UIHostingController for your SwiftUI content
        contentController = UIHostingController(rootView: content)

        // Configure the UIHostingController
        contentController.view.backgroundColor = .blue
        contentController.view.isUserInteractionEnabled = true // Ensure user interaction is enabled on this view

        // Add UIHostingController as a child of your main UIViewController
        mainController.addChild(contentController)

        // Add UIHostingController's view to your PassView
        passView.addSubview(contentController.view)
        contentController.didMove(toParent: mainController)

        // Set the frame
//        contentController.view.frame = passView.bounds
        contentController.view.frame = CGRect(origin: CGPoint(x: passView.bounds.midX, y: passView.bounds.midY), size: CGSize(width: 71, height: 81))

        // Load into window
        window.load(mainController, in: scene)
    }
    
    func loadNew(_ window: SceneWindow, in scene: UIWindowScene, for content: Content) {
        mainController = UIViewController()
        let passView = PassView(frame: scene.coordinateSpace.bounds)
        mainController.view = passView
        

        // Create UIHostingController for your SwiftUI content
        contentController = UIHostingController(rootView: content)

        // Configure the UIHostingController
        contentController.view.backgroundColor = .blue
        contentController.view.isUserInteractionEnabled = true // Ensure user interaction is enabled on this view

        // Add UIHostingController as a child of your main UIViewController
        mainController.addChild(contentController)

        // Add UIHostingController's view to your PassView
        passView.addSubview(contentController.view)
        contentController.didMove(toParent: mainController)

        // Set the frame
//        contentController.view.frame = passView.bounds
        contentController.view.frame = CGRect(origin: CGPoint(x: passView.bounds.midX, y: passView.bounds.midY), size: CGSize(width: 71, height: 81))

        // Load into window
        window.load(mainController, in: scene)
    }
    
    func changeControllerSize(to size: CGSize) {
        guard let contentController else {
            return
        }
        
        let center = CGPoint(x: mainController.view.bounds.midX, y: mainController.view.bounds.midY)
        contentController.view.frame = CGRect(origin: center, size: size)
        mainController.view.setNeedsLayout()
        mainController.view.layoutIfNeeded()
    }
}
