//
//  ApiClient.swift
//  Apiclient
//
//  Created by Adeel Nasir on 05/02/2023.
//

import UIKit

extension API {
    class Client {
        public static let shared = Client()
        public let encoder = JSONEncoder()
        public let decoder = JSONDecoder()
        
        public func fetch<Request, Response>(_ endpoint: Types.Endpoint,
                                             method: Types.method = .get,
                                             body: Request? = nil,
                                             then callback: ((Result<[Response], Types.Error>) -> Void)? = nil
        ) where Request: Encodable , Response: Decodable {
            print(endpoint.url)
            var urlRequest = URLRequest(url: endpoint.url)
            print(urlRequest)
            urlRequest.httpMethod = method.rawValue
            if let body = body {
                do{
                    urlRequest.httpBody = try encoder.encode(body)
                    callback?(.failure(.internal(reason: "Could not encode body")))
                    return
                }
                catch {
                    
                }
            }
            let dataTask = URLSession.shared
                .dataTask(with: urlRequest) {data,response,error in
                    
                    if let error = error {
                        print("fetch error: \(error)")
                        callback?(.failure(.generic(reason: "Could not fetch data")))
                    }
                    else {
                        if let data = data {
                            do {
                                let organizations = try self.decoder.decode([Response].self, from: data)
                                callback?(.success(organizations))
                            } catch {
                                print("Decoding error \(error)")
                                callback?(.failure(.generic(reason: "Could no decode data")))
                            }
                        }
                    }
                    
                }
            dataTask.resume()
        }
        public func get<Response>(_ endpoint: Types.Endpoint,
                                  then callback: ((Result<[Response], Types.Error>) -> Void)? = nil
        ) where Response: Decodable {
            let body : Types.Request.Empty? = nil
            fetch(endpoint, method: .get, body: body) { result in
                callback?(result)
            }
        }
        
    }
}

