//
//  DataManager.swift
//  CurrencyApp
//
//  Created by 123 on 17.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class DataManager {

    static func getData(completion: @escaping ([Valute]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            var data = [Valute]()
            
            data.append(Valute.init(id: "R01010", numCode: "036", charCode: "AUD", nominal: 1, name: "Австралийский доллар", value: 46.7101, picked: false))
            data.append(Valute.init(id: "R01020A", numCode: "944", charCode: "AZN", nominal: 1, name: "Азербайджанский манат", value: 38.6269, picked: false))
            data.append(Valute.init(id: "R01060", numCode: "051", charCode: "AMD", nominal: 100, name: "Армянских драмов", value: 13.5394, picked: false))
            data.append(Valute.init(id: "R01100", numCode: "975", charCode: "BGN", nominal: 1, name: "Болгарский лев", value: 38.8283, picked: false))
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
}
