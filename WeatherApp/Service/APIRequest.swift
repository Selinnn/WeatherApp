//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Selin KAPLAN on 24.04.2021.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest {
    let resourceURL: URL
    
    init(fullurl: String) {
        let resourceString = "\(fullurl)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func post (completion: @escaping(Result<Weather, APIError>) -> Void) {
        
        do {
          var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let weatherData = try JSONDecoder().decode(Weather.self, from: jsonData)
                   completion(.success(weatherData))
                }catch {
                    completion(.failure(.decodingProblem))
                }
                
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
}
