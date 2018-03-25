//
//  Popup.swift
//  readder
//
//  Created by Fran González on 25/3/18.
//  Copyright © 2018 Fran González. All rights reserved.
//

import UIKit

/**
 Shows a simple popup modal with the specified title and message and calls the okayButtonHandler once the user
 presses the "okay" button.
 
 - parameter title: Title of the popup.
 - parameter message: Message shown inside of the popup.
 - parameter buttonTitle: Title of the button shown.
 - parameter buttonHandler: Method to be called once the button inside the popup is pressed.
 
 - returns: UIViewController to present the dialog.
*/
func simpleModal(title: String,
        message: String,
        buttonTitle: String,
        buttonHandler: @escaping () -> Void) -> UIViewController {
    
    let alertController = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
        buttonHandler()
    }
    
    alertController.addAction(okAction)
    
    return alertController
}
