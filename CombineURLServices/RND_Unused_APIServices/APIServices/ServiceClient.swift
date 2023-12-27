// ServiceClient.swift

import Combine
import Foundation
//
//typealias RequestModifier = (URLRequest, String) -> URLRequest
//
//class ServiceClient {
//    
//    ///For basic requests, the URLSession class provides a '.shared' singleton session object that gives you a reasonable
//    ///   default behavior for creating tasks.  if you’re doing anything with caches, cookies, authentication,
//    ///   or custom networking protocols, you should probably be using a default session instead of the shared session.
//    var urlSession: URLSession = .shared
//
//    var baseURL: String {
//            return "http://ip-api.com/"
//    }
//
////    let authManager: AuthManagerProtocol
////    let userAttributes: UserAttributes
////    init(
////        authManager: AuthManagerProtocol,
////        userAttributes: UserAttributes = UserAttributes.shared
////    ) {
////        self.authManager = authManager
////        self.userAttributes = userAttributes
////    }
//
//    func get( endpoint: String, queryItems: [URLQueryItem]? = nil, requestModifier: @escaping RequestModifier ) -> URLSession.ErasedDataTaskPublisher {
//        
//        let path = baseURL.appending("\(endpoint)")
//        
//        //let pimId = userAttributes.pimId
//
////        guard !pimId.isEmpty else {
////            ErrorLogger.logError(className: "ServiceClient", errorName: "No PIM ID", message: "No PIM ID")
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.noPimID).eraseToAnyPublisher()
////        }
//
//        guard var urlComponent = URLComponents(string: path) else {
//            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
//                .eraseToAnyPublisher()
//        }
//
//        //var items = [URLQueryItem(name: "pimId", value: pimId)]
//
////        if let queryItems {
////            
////            queryItems = queryItems
////            
////            items.append(contentsOf: queryItems)
////        }
//
//        //urlComponent.queryItems = items
//        
//        urlComponent.queryItems = queryItems
//
//        guard let url = urlComponent.url else {
//            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
//                .eraseToAnyPublisher()
//        }
//
//        let request = URLRequest(url: url)
//
//        return createPublisher(for: request, requestModifier: requestModifier)
//    }
//
////    /// put without a body
////    func put(
////        endpoint: String,
////        requestModifier: @escaping RequestModifier
////    ) -> URLSession.ErasedDataTaskPublisher {
////        let path = baseURL.appending("\(endpoint)")
//////        let pimId = userAttributes.pimId
//////
//////        guard !pimId.isEmpty else {
//////            ErrorLogger.logError(className: "ServiceClient", errorName: "No PIM ID", message: "No PIM ID")
//////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.noPimID).eraseToAnyPublisher()
//////        }
////
////        guard var urlComponent = URLComponents(string: path) else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        urlComponent.queryItems = [URLQueryItem(name: "pimId", value: pimId)]
////
////        guard let url = urlComponent.url else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        var request = URLRequest(url: url)
////        request.httpMethod = "PUT"
////
////        return createPublisher(for: request, requestModifier: requestModifier)
////    }
////
////    /// put with a body
////    func put(endpoint: String, body: some Codable, requestModifier: @escaping RequestModifier) -> URLSession
////        .ErasedDataTaskPublisher {
////        let path = baseURL.appending("\(endpoint)")
////        let pimId = userAttributes.pimId
////
////        guard !pimId.isEmpty else {
////            ErrorLogger.logError(className: "ServiceClient", errorName: "No PIM ID", message: "No PIM ID")
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.noPimID).eraseToAnyPublisher()
////        }
////
////        guard let body = try? Coder.encode(body) else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.failedEncoding)
////                .eraseToAnyPublisher()
////        }
////
////        guard var urlComponent = URLComponents(string: path) else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        urlComponent.queryItems = [URLQueryItem(name: "pimId", value: pimId)]
////
////        guard let url = urlComponent.url else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        var request = URLRequest(url: url)
////        request.httpMethod = "PUT"
////        request.httpBody = body
////
////        return createPublisher(for: request, requestModifier: requestModifier)
////    }
////
////    func post(endpoint: String, body: some Codable, requestModifier: @escaping RequestModifier) -> URLSession
////        .ErasedDataTaskPublisher {
////        let path = baseURL.appending("\(endpoint)")
////        let pimId = userAttributes.pimId
////
////        guard !pimId.isEmpty else {
////            ErrorLogger.logError(className: "ServiceClient", errorName: "No PIM ID", message: "No PIM ID")
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.noPimID).eraseToAnyPublisher()
////        }
////
////        guard let body = try? Coder.encode(body) else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.failedEncoding)
////                .eraseToAnyPublisher()
////        }
////
////        guard var urlComponent = URLComponents(string: path) else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        urlComponent.queryItems = [URLQueryItem(name: "pimId", value: pimId)]
////
////        guard let url = urlComponent.url else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        var request = URLRequest(url: url)
////        request.httpMethod = "POST"
////        request.httpBody = body
////
////        return createPublisher(for: request, requestModifier: requestModifier)
////    }
////
////    func post(endpoint: String, requestModifier: @escaping RequestModifier) -> URLSession.ErasedDataTaskPublisher {
////        let path = baseURL.appending("\(endpoint)")
////        let pimId = userAttributes.pimId
////
////        guard !pimId.isEmpty else {
////            ErrorLogger.logError(className: "ServiceClient", errorName: "No PIM ID", message: "No PIM ID")
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.noPimID).eraseToAnyPublisher()
////        }
////
////        guard var urlComponent = URLComponents(string: path) else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        urlComponent.queryItems = [URLQueryItem(name: "pimId", value: pimId)]
////
////        guard let url = urlComponent.url else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        var request = URLRequest(url: url)
////        request.httpMethod = "POST"
////
////        return createPublisher(for: request, requestModifier: requestModifier)
////    }
////
////    func patch(endpoint: String, body: some Codable, requestModifier: @escaping RequestModifier) -> URLSession
////        .ErasedDataTaskPublisher {
////        let path = baseURL.appending("\(endpoint)")
////        let pimId = userAttributes.pimId
////
////        guard !pimId.isEmpty else {
////            ErrorLogger.logError(className: "ServiceClient", errorName: "No PIM ID", message: "No PIM ID")
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.noPimID).eraseToAnyPublisher()
////        }
////
////        guard let body = try? Coder.encode(body) else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.failedEncoding)
////                .eraseToAnyPublisher()
////        }
////
////        guard var urlComponent = URLComponents(string: path) else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        urlComponent.queryItems = [URLQueryItem(name: "pimId", value: pimId)]
////
////        guard let url = urlComponent.url else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        var request = URLRequest(url: url)
////        request.httpMethod = "PATCH"
////        request.httpBody = body
////
////        return createPublisher(for: request, requestModifier: requestModifier)
////    }
////
////    func delete(endpoint: String, requestModifier: @escaping RequestModifier) -> URLSession.ErasedDataTaskPublisher {
////        let path = baseURL.appending("\(endpoint)")
////        let pimId = userAttributes.pimId
////
////        guard !pimId.isEmpty else {
////            ErrorLogger.logError(className: "ServiceClient", errorName: "No PIM ID", message: "No PIM ID")
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.noPimID).eraseToAnyPublisher()
////        }
////
////        guard var urlComponent = URLComponents(string: path) else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        urlComponent.queryItems = [URLQueryItem(name: "pimId", value: pimId)]
////
////        guard let url = urlComponent.url else {
////            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.unableToCreateURL)
////                .eraseToAnyPublisher()
////        }
////
////        var request = URLRequest(url: url)
////        request.httpMethod = "DELETE"
////
////        return createPublisher(for: request, requestModifier: requestModifier)
////    }
//
//    private func createPublisher(for request: URLRequest, requestModifier: @escaping RequestModifier) -> URLSession
//        .ErasedDataTaskPublisher {
//        //logRequest(request)
//
//        return authManager.idToken()
//            .retry(3)
//            .flatMap { result in
//                switch result {
//                case let .success(idToken):
//                    return Just(request)
//                        .setFailureType(to: Error.self)
//                        .mapError { [weak self] in
//                            self?.logRequestFailure(request, error: $0 as NSError)
//                            //ErrorLogger.logError($0 as NSError)
//                            return $0
//                        }
//                        .flatMap { [weak self] in
//                            guard let self
//                            else {
//                                return Fail<URLSession.DataTaskPublisher.Output, Error>(
//                                    error: ServiceError
//                                        .badServiceRequest
//                                ).eraseToAnyPublisher()
//                            }
//                            return self.urlSession.erasedDataTaskPublisher(for: requestModifier($0, idToken))
//                        }
//                        .eraseToAnyPublisher()
//                case .failure:
////                    ErrorLogger.logError(
////                        className: "ServiceClient",
////                        errorName: "Auth Token Empty",
////                        message: "idToken is empty"
////                    )
//                    return Fail<URLSession.DataTaskPublisher.Output, Error>(error: ServiceError.noIdToken)
//                        .eraseToAnyPublisher()
//                }
//            }
//            .eraseToAnyPublisher()
//    }
//
////    private func logRequest(_ request: URLRequest) {
////        let logString = """
////
////            \(request.httpMethod.stringOrNil) \(request.url.stringOrNil)
////        """
////        log.info(logString)
////    }
//
////    private func logRequestFailure(_ request: URLRequest, error: Error) {
////        let logString = """
////
////            \(request.httpMethod.stringOrNil) \(request.url.stringOrNil)
////
////            REQUEST FAILED
////            Error: \(error.localizedDescription)
////        """
////        log.error(logString)
////    }
//}
