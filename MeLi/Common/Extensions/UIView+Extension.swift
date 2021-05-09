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
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 22222
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(backgroundView)
    }
    
    func hideLoadingView() {
        if let background = viewWithTag(22222){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
