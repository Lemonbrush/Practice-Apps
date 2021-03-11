//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Александр on 07.03.2021.
//

import Foundation

class NetworkManager: ObservableObject {
    
    // Data storage to be listened to
    @Published var posts = [Post]()
    
    func fetchData() {
        
        // If the url is ok
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            
            // Create session and tru to get data
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    //Try to decode fetched data
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            
                            
                            let results = try decoder.decode(Results.self, from: safeData) // decode into Results from safeData
                            
                            // Getting rid of any delays amond threads
                            DispatchQueue.main.async {
                                self.posts = results.hits // Store fetched data
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            
            // Finish task
            task.resume()
        }
    }
}
