//
//  DataManager.swift
//  CurrencyApp
//
//  Created by 123 on 17.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class DataManager {
    
    static var urlString = App.String.apiBaseUrl

    static func getData(completion: @escaping ([Valute]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            
            QueryService().getCurrency(urlStr: urlString, completion: { (valutes, errorString) in
                if errorString != "" {
                    print(errorString)
                }
                
                if let valutes = valutes {
                    DispatchQueue.main.async {
                        completion(valutes)
                    }
                }
                
                
            })
           
        }
    }
    
}
