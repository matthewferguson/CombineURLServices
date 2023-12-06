//
//  IPLocationService.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson 
//

import Foundation
import Combine

public struct IPLocationService {
//    private var url: URL {
//        urlComponents.url!
//    }
//    private var urlComponents: URLComponents {
//      var components = URLComponents()
//      components.scheme = "http"
//      components.host = "ip-api.com"
//      components.path = "/json/"
//      return components
//    }
    public init() { }
}

extension IPLocationService: IPLocationDataPublisher {
    public func publisher(url:URL) -> AnyPublisher<Data, URLError> {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
