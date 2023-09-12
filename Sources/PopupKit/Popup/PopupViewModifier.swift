//
//  PopupViewModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 9/6/23.
//

import SwiftUI

struct PopupViewModifier<PopupContent: View>: ViewModifier {

    @StateObject var viewModel: PopupViewModel
    @Binding var isPresented: Bool
    
    var backgroundOpacity: Double
    var popupContent: PopupContent
    
    init(isPresented: Binding<Bool>, backgroundOpacity: Double, popupContent: () -> PopupContent) {
        self._isPresented = isPresented
        self.backgroundOpacity = backgroundOpacity
        self.popupContent = popupContent()
        _viewModel = StateObject(wrappedValue: PopupViewModel(isPresented: isPresented.wrappedValue))
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { presented in
                viewModel.manageContentPresentation(isPresented: presented)
            }
            .modifier(PopupPresenterModifier(isPresented: $viewModel.isPopupPresented, popoutContent: contentHost))
    }
    
    var contentHost: some View {
        PopupContentHost(content: popupContent) {
                Color.black
                    .opacity(backgroundOpacity)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented.toggle()
                        }
                    }
                    .transition(.opacity)
        }
        .environmentObject(viewModel)
    }
}

public extension View {
    
    func popout<Content: View>(isPresented: Binding<Bool>, backgroundOpacity: Double = 0.0, @ViewBuilder popupContent: () -> Content) -> some View {
        modifier(PopupViewModifier(isPresented: isPresented, backgroundOpacity: backgroundOpacity, popupContent: popupContent))
    }
}
