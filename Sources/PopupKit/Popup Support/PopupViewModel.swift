//
//  PopupViewModel.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/29/23.
//

import SwiftUI

class PopupViewModel: ObservableObject {
    
    @Published var isPopupPresented: Bool
    @Published var isContentPresented: Bool
            
    init(isPresented: Bool) {
        isPopupPresented = isPresented
        isContentPresented = isPresented
    }

    func manageContentPresentation(isPresented: Bool) {
        if isPresented {
            isPopupPresented = true
        }
        else {
            withAnimation {
                isContentPresented = isPresented
            }
        }
    }
}
