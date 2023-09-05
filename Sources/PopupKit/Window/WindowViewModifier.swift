//
//  WindowViewModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

struct WindowViewModifier<WindowContent: View>: ViewModifier {
        
    @Binding var isPresented: Bool
    @ViewBuilder var windowContent: WindowContent

    @StateObject var viewModel: WindowViewModel<WindowContent>
    
    init(level: UIWindow.Level, isPresented: Binding<Bool>, @ViewBuilder windowContent: () -> WindowContent) {
        _viewModel = StateObject(wrappedValue: WindowViewModel(level: level, isPresented: isPresented.wrappedValue))
        self._isPresented = isPresented
        self.windowContent = windowContent()
    }
        
    func body(content: Content) -> some View {
        content
            .windowLoader(for: viewModel.window, windowContent: contentHost, size: $viewModel.contentSize)
            .onChange(of: isPresented) { presented in
                viewModel.manageContentPresentation(isPresented: presented)
            }
            .onChange(of: viewModel.isWindowPresented) { presented in
                viewModel.manageWindowVisibility(isPresented: presented)
            }
    }
    
    var contentHost: some View {
        WindowContentHost(content: windowContent)
            .environmentObject(viewModel)
    }
}

public extension View {
    func window<Content: View>(level: UIWindow.Level = .normal, isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        modifier(WindowViewModifier(level: level, isPresented: isPresented, windowContent: content))
    }
}
