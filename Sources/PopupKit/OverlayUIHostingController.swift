//
//  OverlayUIHostingController.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/23/23.
//

import SwiftUI

final class OverlayUIHostingController<Content: View>: UIViewController {
    
    private var rootView: Content?
    
    init(rootView: Content) {
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hostingController = UIHostingController(rootView: rootView)
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        hostingController.view.frame = self.view.bounds
        hostingController.didMove(toParent: self)
    }
}
