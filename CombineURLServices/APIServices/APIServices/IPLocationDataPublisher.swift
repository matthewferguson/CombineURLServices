//
//  IPLocationDataPublisher.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson 
//

import Foundation
import Combine

public protocol IPLocationDataPublisher {
    func publisher(url:URL) -> AnyPublisher<Data, URLError>
}
