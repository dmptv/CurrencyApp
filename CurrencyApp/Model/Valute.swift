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
    var picked: Bool 
    
    
}
    
//    enum CodingKeys: String, CodingKey {
//        case id = "ID"
//        case numCode = "NumCode"
//        case charCode = "CharCode"
//        case nominal = "Nominal"
//        case name = "Name"
//        case value = "Value"
//    }
//}
//
//extension Valute: Encodable {
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(numCode, forKey: .numCode)
//        try container.encode(charCode, forKey: .charCode)
//        try container.encode(nominal, forKey: .nominal)
//        try container.encode(name, forKey: .name)
//        try container.encode(value, forKey: .value)
//
//    }
//}
//
//extension Valute: Decodable {
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(String.self, forKey: .id)
//        numCode = try values.decode(String.self, forKey: .numCode)
//        charCode = try values.decode(String.self, forKey: .charCode)
//        nominal = try values.decode(Int.self, forKey: .nominal)
//        name = try values.decode(String.self, forKey: .name)
//        value = try values.decode(Double.self, forKey: .value)
//    }
//}






































