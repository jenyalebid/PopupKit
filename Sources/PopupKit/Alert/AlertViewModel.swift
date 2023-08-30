//
//  AlertViewModel.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/24/23.
//

import Foundation

class AlertViewModel: ObservableObject {
    
    enum ButtonLayout {
        case single
        case double
        case more
    }
        
    var alert: SceneAlert
    var layout = ButtonLayout.single
    
    var dismissButton = AlertButton(text: "Cancel", role: .cancel, action: {})
    var secondaryButton = AlertButton(text: "Okay", role: .regular, action: {})
    
    var destructiveButtons = [AlertButton]()
    var regularButtons = [AlertButton]()
    
    init(alert: SceneAlert) {
        self.alert = alert
        sortButtons()
    }
    
    private func sortButtons() {
        switch alert.buttons.count {
        case 0:
            layout = .single
            dismissButton = secondaryButton
            return
        case 1:
            setupSingle()
            return
        case 2:
            setupDouble()
            return
        default:
            assignButtons()
        }
    }
    
    func setupSingle() {
        let button = alert.buttons[0]
        layout = button.role == .destructive ? .double : .single
        if button.role == .destructive {
            secondaryButton = alert.buttons[0]
        }
    }
    
    func setupDouble() {
        layout = .double
        let firstButton = alert.buttons[0]
        let secondButton = alert.buttons[1]
        
        dismissButton = firstButton.role == .cancel ? firstButton : secondButton.role == .cancel ? secondButton : firstButton
        secondaryButton = dismissButton == firstButton ? secondButton : firstButton
    }
    
    private func assignButtons() {
        for button in alert.buttons {
            switch button.role {
            case .cancel:
                dismissButton = button
            case .destructive:
                destructiveButtons.append(button)
            case .regular:
                regularButtons.append(button)
            }
//            if cancelButton == nil {
//                cancelButton = AlertButton(text: "Cancel", role: .cancel, action: {})
//            }
        }
    }
}
