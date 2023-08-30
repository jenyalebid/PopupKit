//
//  AlertModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/25/23.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    var alert: SceneAlert
    
    func body(content: Content) -> some View {
        content
    }
}
