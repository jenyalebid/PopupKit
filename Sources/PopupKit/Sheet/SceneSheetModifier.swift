//
//  SceneSheetModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/12/24.
//

import SwiftUI

struct SceneSheetModifier<SheetContent: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    var sheetContent: () -> SheetContent
    
    func body(content: Content) -> some View {
        content
            .background(SceneSheet(isPresented: $isPresented, content: sheetContent))
    }
}

public extension View {
    
    func sceneSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(SceneSheetModifier(isPresented: isPresented, sheetContent: content))
    }
}
