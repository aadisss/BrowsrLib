//
//  ApiTypes.swift
//  Apiclient
//
//  Created by Adeel Nasir on 05/02/2023.
//

import UIKit

extension API {
    public enum Types {
        public enum Response {
            
            public struct Organization: Decodable {
                public var id: Int
                public var login: String
                public  var avatar_url: String
                    }
            
        }
        public enum Request {
            public struct Empty: Encodable {}
        }
        public enum Error: LocalizedError {
            case generic(reason:String)
            case `internal`(reason:String)
            
            public var errorDescription: String? {
                switch self {
                case .generic(let reason):
                    return reason
                case .internal(let reason):
                    return "Internal Error:\(reason)"
                }
            }
            
        }
        public enum Endpoint {
            case search
            case lookup(id: Int)
            
            public var url : URL{
                var components = URLComponents()
                components.host = "api.github.com"
                components.scheme = "https"
                switch self {
                case .search :
                    components.path = "/organizations"
                case .lookup(let id):
                    components.path = "/lookup"
                    components.queryItems = [
                    URLQueryItem(name: "id", value: "\(id)")
                    ]
                }
                return components.url!
            }
        }
        public enum method : String {
            case get
            case post
        }
    }
}
