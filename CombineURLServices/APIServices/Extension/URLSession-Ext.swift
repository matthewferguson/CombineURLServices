
import Combine
import Foundation

//public extension URLSession {
//    
//    typealias ErasedDataTaskPublisher = AnyPublisher<(data: Data, response: URLResponse), Error>
//
//    func erasedDataTaskPublisher(for request: URLRequest) -> ErasedDataTaskPublisher {
//        dataTaskPublisher(for: request)
//            .tryMap { data, response in
//                if let response = response as? HTTPURLResponse, !(200 ... 299).contains(response.statusCode) {
//                    
//                    if response.statusCode == 401 {
//                        throw ServiceError.unauthorized
//                    }
//
//                    if (500 ... 599).contains(response.statusCode) {
//                        throw ServiceError.serverError
//                    }
//                }
//                return (data, response)
//            }
//            .eraseToAnyPublisher()
//    }
//}
