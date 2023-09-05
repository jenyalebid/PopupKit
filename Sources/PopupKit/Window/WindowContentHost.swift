//
//  WindowContentHost.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

struct WindowContentHost<Content: View>: View {
    
    @EnvironmentObject var viewModel: WindowViewModel<Content>
    var content: Content
    
    var body: some View {
        ZStack {
            if viewModel.isContentPresented {
                content
                    .onDisappear {
                        viewModel.isWindowPresented = false
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    viewModel.isContentPresented = true
                }
            }
        }
    }
}
