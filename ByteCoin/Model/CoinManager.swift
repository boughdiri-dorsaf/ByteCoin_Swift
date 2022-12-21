//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8B891761-FFB8-426F-BD7A-9D08F8280974"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fetchData(_ idQuote: String){
        let urlString = "\(baseURL)/\(idQuote)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        
        //1 - Create URL
        if let url = URL(string: urlString) {
            //2 -Create a URLSession
            let session  = URLSession(configuration: .default)
            
            //3 -Give the session task
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let response =  parseJSON(bitcoinData: safeData){
                        delegate?.didUpdateCoin(self, coin: response)
                    }
                }
            }
            //4 - Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(bitcoinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: bitcoinData)
            let name = decodedData.asset_id_quote
            let rate = decodedData.rate
            
            let coin = CoinModel(name: name, rate: rate)
            
            return coin
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
    
}
