//
//  Popup.swift
//  readder
//
//  Created by Fran González on 25/3/18.
//  Copyright © 2018 Fran González. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     Shows a simple popup modal with the specified title and message and calls the buttonHandler once the user
     presses the "okay" button.
     
     - parameter title: Title of the popup.
     - parameter message: Message shown inside of the popup.
     - parameter buttonTitle: Title of the button shown.
     - parameter buttonHandler: Method to be called once the button inside the popup is pressed.
     
     - returns: UIViewController to present the dialog.
     */
    func showPopup(title: String,
                   message: String,
                   buttonTitle: String,
                   buttonHandler: @escaping () -> Void) {
        // Create the basic alert controller.
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        // Add the "Okay" (or however we want to call it) button.
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
            buttonHandler()
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Shows a popup modal with a title, message and a Text Field. The text field will be returned
     in the buttonHandler once the user presses the "okay" (or whatever title it's given) button.
     
     - parameter title: Title of the popup.
     - parameter message: Message shown inside of the popup.
     - parameter textFieldPlaceholder: Message shown as a placeholder in the TextField.
     - parameter buttonTitle: Title of the button shown.
     - parameter buttonHandler: Method to be called once the button inside the popup is pressed.
     
     - returns: UIViewController to present the dialog.
     */
    func showInputPopup(title: String,
                        message: String,
                        textFieldPlaceholder: String,
                        buttonTitle: String,
                        buttonHandler: @escaping (String) -> Void) {
        // Create the basic alert controller.
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        // Create the Text Field with the placeholder.
        alert.addTextField { textField in
            textField.placeholder = textFieldPlaceholder
            textField.addTarget(self,
                                action: #selector(self.textChangedTarget),
                                for: .editingChanged)
        }
        
        // Add the "Okay" (or however we want to call it) button that returns the Text Field.
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
            // Get the first Text Field (the one we just added).
            let inputField = alert.textFields![0]
            
            buttonHandler(inputField.text!)
        })
        
        // Disable the button until the user inputs something.
        alert.actions[0].isEnabled = false
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Target that checks whether there's any valid text inside the TextField.
    */
    @objc func textChangedTarget(_ sender: Any) {
        // Since this function is (or should be) always fired by the addTarget method on a TextField,
        // the first sender is always going to be an UITextField.
        let textField = sender as! UITextField
        var responder: UIResponder! = textField
        
        // But who knows when we're finally going to find the UIAlertController, so keep iterating
        // through the sender until we find it.
        while !(responder is UIAlertController) {
            responder = responder.next
        }
        
        let alert = responder as! UIAlertController
        
        // Once found, enable or disable the button based on the inputted text.
        alert.actions[0].isEnabled = textField.text != ""
    }
}
