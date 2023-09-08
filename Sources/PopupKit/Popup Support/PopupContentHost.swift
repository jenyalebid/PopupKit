//
//  PopupContentHost.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

struct PopupContentHost<Content: View>: View {
    
    @EnvironmentObject var viewModel: PopupViewModel
    var content: Content
    
    var body: some View {
        ZStack {
            if viewModel.isContentPresented {
                content
                    .onDisappear {
                        viewModel.isPopupPresented = false
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
