//
//  AlertButton.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/23/23.
//

import Foundation

public struct AlertButton: Equatable {
    
    public static func == (lhs: AlertButton, rhs: AlertButton) -> Bool {
        lhs.text == rhs.text
    }
    
    public init(text: String, role: AlertButtonRole = .regular, action: @escaping () -> Void) {
        self.text = text
        self.role = role
        self.action = action
    }
    
    var text: String
    var action: () -> Void
    var role: AlertButtonRole
}
