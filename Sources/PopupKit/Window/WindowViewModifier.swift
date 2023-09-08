//
//  WindowViewModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

struct WindowViewModifier<WindowContent: View>: ViewModifier {
        
    @Binding var isPresented: Bool
    var windowContent: WindowContent
    
    @State var window: SceneWindow

    @StateObject var viewModel: PopupViewModel
    
    init(level: UIWindow.Level, isPresented: Binding<Bool>, windowContent: () -> WindowContent) {
        _viewModel = StateObject(wrappedValue: PopupViewModel(isPresented: isPresented.wrappedValue))
        self._isPresented = isPresented
        _window = State(wrappedValue: SceneWindow(level: level))
        self.windowContent = windowContent()
    }
        
    func body(content: Content) -> some View {
        content
            .windowLoader(for: window, windowContent: contentHost)
            .onChange(of: isPresented) { presented in
                viewModel.manageContentPresentation(isPresented: presented)
            }
            .onChange(of: viewModel.isPopupPresented) { presented in
                presented ? window.show() : window.destroy()
            }
    }

    var contentHost: some View {
        PopupContentHost(content: windowContent)
            .environmentObject(viewModel)
    }
}

public extension View {
    func window<Content: View>(level: UIWindow.Level = .normal, isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        modifier(WindowViewModifier(level: level, isPresented: isPresented, windowContent: content))
    }
}
