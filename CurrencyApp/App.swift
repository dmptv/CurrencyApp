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
        private static let devBaseUrl = "https://api.vk.com/method/"
        private static let prodBaseUrl = "https://api.vk.com/method/"
        
        static var baseUrl: Swift.String {
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
