//
//  RequestBuilder.swift
//  CurrencyApp
//
//  Created by 123 on 17.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

class QueryService {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Valute]?, String) -> Void
    typealias QueryRates = (Double, String) -> Void
    
    var valutes: [Valute] = []
    var errorMessage = ""
    var valuteRate: Double = 0
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    static var charCodeKeys: [String] = []
    
    func getRates(inputCharCode: String, baseCharCode: String, completion: @escaping QueryRates) {
        let strQuery = "\(baseCharCode)" + "_" + "\(inputCharCode)"
        dataTask?.cancel()

        
        guard let url = URL(string: "https://free.currencyconverterapi.com/api/v6/convert?q=\(strQuery)&compact=ultra") else { return }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
         
            if error != nil {
                self.errorMessage += "Error happens"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                let resRate = try! JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                
                if let resRate = resRate, let key = resRate.keys.first  {
                    if  resRate[key] as? String == "status" {
                        self.errorMessage += "Don't spam! Wait a bit"
                    }
                    
                    completion(resRate[key] as! Double, self.errorMessage)
                }
            }
        }
        dataTask?.resume()
        
        completion(self.valuteRate, self.errorMessage)
    }
    
    func getCurrency(urlStr: String, completion: @escaping QueryResult) {
        dataTask?.cancel()
       
            guard let url = URL(string: urlStr) else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                    
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateResults(data)
                    
                    DispatchQueue.main.async {
                        completion(self.valutes, self.errorMessage)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(self.valutes, self.errorMessage)
                }
            }
            dataTask?.resume()
    }
    
    fileprivate func updateResults(_ data: Data) {
        var response: JSONDictionary?
        valutes.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        
        guard let dictionary = response!["Valute"] as? [String: Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }

        
        dictionary.keys.forEach { key in
            let object: JSONDictionary = dictionary[key] as! QueryService.JSONDictionary
            let valute = Valute.init(with: object)
            valutes.append(valute)
            QueryService.charCodeKeys.append(key)
        }
      
    }
    
}


















