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
                    let sortedValutes = moveCharCodeToEnd(valutes)
                    DispatchQueue.main.async {
                        completion(sortedValutes)
                    }
                }
                
            })
           
        }
    }
    
    static func moveCharCodeToEnd(_ valutes: [Valute], charCode: String = "USD") ->  [Valute] {
        var valutes = valutes
        if let i = valutes.firstIndex(where: { $0.charCode == charCode }) {
            let valute = valutes[i]
            valutes.remove(at: i)
            valutes.insert(valute, at: valutes.endIndex)
            return valutes
        }
        return valutes
    }
    
}
