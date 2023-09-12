//
//  PopupContentHost.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

struct PopupContentHost<Content: View, Background: View>: View {
    
    @EnvironmentObject var viewModel: PopupViewModel
    
    var content: Content
    @ViewBuilder var background: Background
    
    var body: some View {
        Group {
            ZStack {
                if viewModel.isContentPresented {
                    content
                        .zIndex(1) // SwiftUI...
                        .onDisappear {
                            viewModel.isPopupPresented = false
                        }
                    background
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    viewModel.isContentPresented = true
                }
            }
        }
    }
}
