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
    
    var popupContent: PopupContent
    
    init(isPresented: Binding<Bool>, popupContent: () -> PopupContent) {
        self._isPresented = isPresented
        self.popupContent = popupContent()
        _viewModel = StateObject(wrappedValue: PopupViewModel(isPresented: isPresented.wrappedValue))
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { presented in
                viewModel.manageContentPresentation(isPresented: presented)
            }
            .modifier(PopoutPresenterModifier(isPresented: $viewModel.isPopupPresented, popoutContent: contentHost))
    }
    
    var contentHost: some View {
        PopupContentHost(content: popupContent)
            .environmentObject(viewModel)
    }
}

public extension View {
    
    func popout<Content: View>(isPresented: Binding<Bool>, @ViewBuilder popupContent: () -> Content) -> some View {
        modifier(PopupViewModifier(isPresented: isPresented, popupContent: popupContent))
    }
}
