//
//  String+Extension.swift
//  MeLi
//
//  Created by Rodrigo Camara on 25/05/2021.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment:"NOT_FOUND")
    }
    
}
