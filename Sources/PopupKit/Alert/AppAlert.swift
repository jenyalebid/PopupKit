//
//  AppAlert.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/23/23.
//

import Foundation

public final class AppAlert {
    
    public init(title: String, body: String, buttons: [AlertButton]) {
        self.title = title
        self.body = body
        self.buttons = buttons
    }
    
    public var title: String
    public var body: String
    
    var buttons: [AlertButton]
}
