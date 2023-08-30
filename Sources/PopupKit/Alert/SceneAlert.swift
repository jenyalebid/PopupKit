//
//  SceneAlert.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/23/23.
//

import Foundation

public struct SceneAlert {
    
    public init(title: String?, message: String?, buttons: [AlertButton]) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
    
    public var title: String?
    public var message: String?
    
    var buttons: [AlertButton]
}
