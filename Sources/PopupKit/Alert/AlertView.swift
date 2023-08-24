//
//  AlertView.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/23/23.
//

import SwiftUI

struct AlertView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var alert: AppAlert
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                VStack(spacing: 0) {
                    Text(alert.title)
                        .font(.headline)
                        .padding()
                    Divider()
                    AlertMessageView(message: alert.body)
                        .padding()
                    Divider()
                        .padding(.bottom, 6)
                    HStack(spacing: 0) {
                        Button {
                            
                        } label: {
                            Text("Let's Do It")
                                .padding()
                                .frame(width: 148)
                                .lineLimit(1)
                        }
                        .tint(.red)
                        Divider()
                            .frame(height: 52)
                        Button {
                            
                        } label: {
                            Text("Cancel")
                                .fontWeight(.bold)
                                .padding()
                                .frame(width: 148)
                        }
                    }
                }
                .frame(width: 300, alignment: .center)
                .background(.ultraThinMaterial)
                .cornerRadius(9)
                .shadow(radius: 1)
                .padding()
                .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

fileprivate struct AlertButtonsView: View {
    
    var buttons: [AlertButton]
    
    var body: some View {
        
        switch buttons.count {
        case 1:
            EmptyView()
        case 2:
            EmptyView()
        default:
            EmptyView()
        }
    }
}

fileprivate struct AlertMessageView: View {
    
    var message: String
    
    var body: some View {
        if message.count < 200 {
            messageText
        }
        else {
            ScrollView {
                messageText
                    .padding(.horizontal, 6)
            }
            .frame(maxHeight: 300)
            .overlay {
                RoundedRectangle(cornerRadius: 9)
                    .stroke()
                    .foregroundColor(Color(uiColor: .systemGray4))
            }
        }
    }
    
    var messageText: some View {
        Text(message)
            .font(.callout)
            .multilineTextAlignment(.center)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(alert: AppAlert(title: "Testing Title", body: "All data will be deleted and it cannot be returned.", buttons: [AlertButton(text: "Let's Do It!", action: {}), AlertButton(text: "Cancel", action: {})]))
    }
}
