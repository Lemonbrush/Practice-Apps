//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Александр on 24.02.2021.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(_ delegate: CoinManager ,error: Error)
    func didUpdateData(_ delegate: CoinManager, with data: CoinData)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "2DC23942-BD3A-4F40-A934-58FA99544EC6"
    
    var currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    // MARK: Networking
    
    func getCoinPrice(for currency: String) {
        
        let urlString = baseURL + "/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    //print( String(data: safeData, encoding: .utf8) )
                    let bitcoinPrice = parseJSON(safeData)
                    
                    delegate?.didUpdateData(self, with: bitcoinPrice!)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinData? {
        
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(CoinData.self, from: data)
            //let lastPrice = decodedData.rate
            
            return decodedData
            
        } catch {
            
            delegate?.didFailWithError(self, error: error)
            return nil
            
        }
    }
}
