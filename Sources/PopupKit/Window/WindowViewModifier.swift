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

    @StateObject var viewModel: WindowViewModel
    
    init(level: UIWindow.Level, isPresented: Binding<Bool>, @ViewBuilder windowContent: () -> WindowContent) {
        _viewModel = StateObject(wrappedValue: WindowViewModel(level: level, isPresented: isPresented.wrappedValue))
        self._isPresented = isPresented
        self.windowContent = windowContent()
    }
    
    //TODO: Move things into viewModel.
    
    func body(content: Content) -> some View {
        content
            .windowLoader(for: viewModel.window, windowContent: contentHost)
            .onChange(of: isPresented) { presented in
                if presented {
                    viewModel.isWindowPresented = true
                }
                else {
                    withAnimation {
                        viewModel.isContentPresented = presented
                    }
                }
            }
            .onChange(of: viewModel.isWindowPresented) { presented in
                presented ? viewModel.window.makeKeyAndVisible() : viewModel.window.destroy()
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

struct WindowViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
        }
    }
}
