//
//  IPLocationDataPublisher.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson on 11/21/23.
//

import Foundation
import Combine

public protocol IPLocationDataPublisher {
    func publisher(url:URL) -> AnyPublisher<Data, URLError>
}
