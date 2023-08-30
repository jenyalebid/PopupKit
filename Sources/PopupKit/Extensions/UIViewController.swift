//
//  UIViewController.swift
//  PopupKit
//
//  Created by Jenya Lebid on 8/26/23.
//

import UIKit

public extension UIViewController  {
    
    func removeAllChildren() {
        children.forEach {$0.removeFromParent()}
    }
}
