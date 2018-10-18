//
//  UIAlertController+Extentions.swift
//  CurrencyApp
//
//  Created by 123 on 18.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

/// разширение для UIAlertController, которое упрощает
/// создание простого алерта с кнопкой отмены
extension UIAlertController {
    
    convenience init(title: String, cancelTitle: String) {
        
        self.init(title: title, message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelTitle,
                                         style: .cancel,
                                         handler: nil)
        
        self.addAction(cancelAction)
    }
}
