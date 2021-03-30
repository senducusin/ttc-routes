//
//  WebService.swift
//  TTC-Routes
//
//  Created by Jansen Ducusin on 3/30/21.
//

import Foundation

enum NetworkError:Error {
    case domainError
    case urlError
    case decodeError
}

enum HttpMethod:String {
    case post = "POST"
    case get = "GET"
}

struct Resource<T:Codable>{
    var url: URL
    var httpMethod: HttpMethod = .get
    var httpBody: Data? = nil
}

extension Resource {
    init(url:URL) {
        self.url = url
    }
}


class WebService{
    func load<T>(resource:Resource<T>, completion:@escaping(Result<T,NetworkError>)->()){
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil,
                  let data = data else {
                completion(.failure(.domainError))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
                
            }catch{
                completion(.failure(.decodeError))
            }
            
        }.resume()
    }
}
