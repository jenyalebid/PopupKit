//
//  WindowViewModifier.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/26/23.
//

import SwiftUI

//struct WindowViewModifier<WindowContent: View>: ViewModifier {
//    
//    @State var window: AppWindow<WindowPresenter<WindowContent>>!
//    
//    @ViewBuilder var windowContent: WindowContent
//    
//    @Binding var isPresented: Bool
//    @State private var isLocalPresented = false
//    
//    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> WindowContent) {
//        self._isPresented = isPresented
//        self.windowContent = content()
//    }
//    
//    func body(content: Content) -> some View {
//        content
//            .onAppear {
//                window = AppWindow(WindowPresenter(isPresented: $isLocalPresented, content: windowContent))
//            }
//            .onChange(of: isPresented) { newValue in
//                if newValue {
//                    window.present()
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
//                    withAnimation {
//                        isLocalPresented = newValue
//                    }
//                }
//
//                if !newValue {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
//                        window.dismiss()
//                    }
//                }
//
//            }
//    }
//}
//
//public struct WindowPresenter<WindowContent: View>: View {
//
//    @Binding var isPresented: Bool
//    
//    var content: WindowContent
//
//    public init(isPresented: Binding<Bool>, content: WindowContent) {
//        self._isPresented = isPresented
//        self.content = content
//    }
//
//    public var body: some View {
//        VStack {
//            if isPresented {
//                content
//            }
//        }
////        .onChange(of: isPresented) { newValue in
////            withAnimation {
////                isLocalPresented = newValue
////            }
////        }
//    }
//}
//
//public extension View {
//    
//    func window<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
//        modifier(WindowViewModifier(isPresented: isPresented, content: content))
//    }
//}
