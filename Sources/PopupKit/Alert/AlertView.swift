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
        
    @StateObject var viewModel: AlertViewModel
    
    init(_ alert: AppAlert) {
        _viewModel = StateObject(wrappedValue: AlertViewModel(alert: alert))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(uiColor: .label)
                    .ignoresSafeArea()
                    .opacity(0.2)
                    .transition(.opacity)
                VStack(spacing: 0) {
                    if let title = viewModel.alert.title {
                        Text(title)
                            .font(.headline)
                            .padding()
                    }
                    if let message = viewModel.alert.message {
                        AlertMessageView(message: message)
                            .padding()
                    }
                    Divider()
                    AlertButtonsView()
                        .environmentObject(viewModel)
                }
                .frame(width: 300, alignment: .center)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 1)
                .padding()
                .transition(.scale)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

fileprivate struct AlertButtonsView: View {
    
    @EnvironmentObject var viewModel: AlertViewModel
    
    var body: some View {
        switch viewModel.layout {
        case .single:
            dismissButton
        case .double:
            twoButton
        case .more:
            EmptyView()
        }
    }
    
    var dismissButton: some View {
        buttonView(for: viewModel.dismissButton)
    }
    
    var twoButton: some View {
        HStack(spacing: 0) {
            dismissButton
            Divider()
                .frame(height: 52)
            buttonView(for: viewModel.secondaryButton)
        }
    }
    
    func buttonView(for button: AlertButton) -> some View {
        Button {
            button.action()
        } label: {
            Text(button.text)
                .fontWeight(fontWeight(for: button))
                .padding()
                .frame(maxWidth: .infinity)
                .lineLimit(1)
        }
        .tint(color(for: button))
    }
    
    func color(for button: AlertButton) -> Color {
        switch button.role {
        case .destructive:
            return .red
        default:
            return .accentColor
        }
    }
    
    func fontWeight(for button: AlertButton) -> Font.Weight {
        switch button.role {
        case .cancel:
            return .bold
        default:
            return .regular
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
        AlertView(AppAlert(title: "Test", message: "some message goes here. some message goes here. some message goes here. some message goes here. some message, asome mes", buttons: [AlertButton(text: "DO IT", role: .destructive, action: {}), AlertButton(text: "DO re", role: .regular, action: {})]))
            .previewDevice("iPhone SE (3rd generation)")
    }
}
