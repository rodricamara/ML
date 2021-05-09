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
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: { (UIAlertAction) -> Void in
                                        completion()
                                      }))
        
        present(alert, animated: true, completion: nil)
    }
}
