//
//  JSONDecode.swift

import Combine
import Foundation

public extension Publisher {
    func decodeFromJson<Item>(_ type: Item.Type) -> Publishers.Decode<Self, Item, JSONDecoder>
        where Item: Decodable, Self.Output == JSONDecoder.Input {
        decode(type: type, decoder: JSONDecoder())
    }
}
