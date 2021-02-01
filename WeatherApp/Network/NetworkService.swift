//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 27/01/2021.
//

import Foundation

class NetworkService {
    
    class func request<T: Codable>(router: Router, completion: @escaping (T) -> ()) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        
        // TODO: Refactor error section
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "Error")
                return
            }
            
            guard response != nil else {
                print("no response")
                return
            }
            
            guard let receivedData = data else {
                print("no data")
                return
            }
            
            let responseObject = try! JSONDecoder().decode(T.self, from: receivedData)
            
            DispatchQueue.main.async {
                completion(responseObject)
            }
            
        }
        
        dataTask.resume()
        
    }
    
}
