//
//  UIViewController+Extension.swift
//  MeLi
//
//  Created by Rodrigo Camara on 08/05/2021.
//

import UIKit

extension UIViewController {
    
    func showErrorWithMessage(_ message: String) {
        showErrorWithMessage(message, completion: {})
    }
    
    func showErrorWithMessage(_ message: String, completion: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Error",
                message: message,
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "Ok",
                style: .default,
                handler: { _ -> Void in
                    completion()
                }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
