//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(_ coinModel: CoinModel)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "21692B6D-0540-4746-BCC7-22675F04617D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fetchPrice(country: String){
        let url = "\(baseURL)/\(country)"
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
            
            let session = URLSession(configuration: .default)
            
            let  task = session.dataTask(with: urlRequest) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                 
                if let safeData = data {
                    if let coin = self.parseJson(safeData) {
                        self.delegate?.didUpdateRate(coin)
                    }
                }
            }
             
            task.resume()
        }
        
    }
    
    func parseJson(_ coinData: Data) -> CoinModel? {
        
        let decoder = JSONDecoder()
            do {
                let decodedData =  try decoder.decode(CoinData.self, from: coinData)
                let rate = decodedData.rate
                let country = decodedData.asset_id_quote
                let coin = CoinModel(rate: rate, country: country)
                return coin
                
            } catch {
                delegate?.didFailWithError(error)
                return nil
               }
    }

    
}
