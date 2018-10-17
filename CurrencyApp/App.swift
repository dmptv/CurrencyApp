//
//  App.swift
//  CurrencyApp
//
//  Created by 123 on 17.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit


struct App {
    
    // MARK: - Strings
    
    struct String {
        private static let devBaseUrl = "https://www.cbr-xml-daily.ru/daily_json.js"
        private static let prodBaseUrl = "https://www.cbr-xml-daily.ru/daily_json.js"
        
        private static var baseUrl: Swift.String {
            return Environment.current == .production ? prodBaseUrl : devBaseUrl
        }
        
        static var apiBaseUrl: Swift.String {
            return baseUrl
        }
        
        
    }
    
    // MARK: - Environment
    
    enum Environment {
        case development
        case production
        
        static var current: Environment {
            return .development
        }
    }
    
    // MARK: - Integers
    
    struct Int {
        static let heightMainCell = 60
        
    }

}
