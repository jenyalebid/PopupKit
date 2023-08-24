//
//  AlertButton.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/23/23.
//

import Foundation

public final class AlertButton {
    
    public init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    
    var text: String
    var action: () -> Void
}
