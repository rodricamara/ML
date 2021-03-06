//
//  UIView+Extension.swift
//  MeLi
//
//  Created by Rodrigo Camara on 09/05/2021.
//

import UIKit

extension UIView{
    
    func showLoadingView(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: bounds.width, height: bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 22222
        
        let activityIndicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = center
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        addSubview(backgroundView)
    }
    
    func hideLoadingView() {
        if let background = viewWithTag(22222) {
            background.removeFromSuperview()
        }
        isUserInteractionEnabled = true
    }
}
