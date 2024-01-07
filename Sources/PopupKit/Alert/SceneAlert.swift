//
//  SceneAlert.swift
//  PopupKit
//
//  Created by Jenya Lebid on 1/7/24.
//

import Foundation
import UIKit

public struct SceneAlert {
    
    public init(title: String?, message: String?, textFields: [AlertTextField]? = nil, buttons: [AlertButton]?) {
        self.title = title
        self.message = message
        self.textFields = textFields
        self.buttons = buttons
    }
    
    public var title: String?
    public var message: String?
    
    public var textFields: [AlertTextField]?
    public var buttons: [AlertButton]?
}

extension SceneAlert {
    
    var uiAlert: UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        textFields?.forEach { field in
            alert.addTextField { textField in
                textField.placeholder = field.placehoder
                textField.text = field.text.wrappedValue
                
                NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { _ in
                    field.text.wrappedValue = textField.text ?? ""
                }
            }
        }
        
        buttons?.forEach { button in
            alert.addAction(button.uiAction)
        }
        
        if buttons == nil {
            alert.addAction(AlertButton.ok.uiAction)
        }
        
        return alert
    }
}
