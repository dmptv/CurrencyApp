//
//  Valute.swift
//  CurrencyApp
//
//  Created by 123 on 17.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation


struct Valute {
    var id: String
    var numCode: String
    var charCode: String
    var nominal: Int
    var name: String
    var value: Double
    var picked: Bool = false
    
    init(with dictionary: [String: Any]) {
        self.id = dictionary["ID"] as? String ?? "NO ID"
        self.numCode = dictionary["NumCode"] as? String ?? "NO NumCode"
        self.charCode = dictionary["CharCode"] as? String ?? "No CharCode"
        self.nominal = dictionary["Nominal"] as? Int ?? -1
        self.name = dictionary["Name"] as? String ?? "No Name"
        self.value = dictionary["Value"] as? Double ?? -000
    }
}
    







































