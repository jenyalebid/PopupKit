//
//  ViewSizeCalculatorModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/31/23.
//

import SwiftUI

struct ViewSizeCalculatorModifier: ViewModifier {
    
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}

public extension View {
    
    func calculateSize(in size: Binding<CGSize>) -> some View {
        modifier(ViewSizeCalculatorModifier(size: size))
    }
}
