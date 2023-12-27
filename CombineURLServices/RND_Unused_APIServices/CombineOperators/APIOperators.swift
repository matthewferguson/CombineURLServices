//
//  APIOperators.swift

import Combine
import Foundation

//public extension URLSession.ErasedDataTaskPublisher {
//    
//    func unwrapResultJSONFromAPI() -> Self {
//        tryMap {
//            if let json = try JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any]/*, let result = (json["result"] as? [String: Any])*/ {
//                let data = try JSONSerialization.data(withJSONObject: json, options: [])
//                return (data: data, response: $0.response)
//            }
//            return $0
//        }
//        .eraseToAnyPublisher()
//    }
//    
//}
