//
//  IPGeoLocationClient.swift
//  CombineURLServices
//
//  Matthew Ferguson on 11/12/23.
//

import Combine
import Foundation

protocol IPGeoLocationServiceClientProtocol {
    func getIP() -> AnyPublisher<Result<IPLocation, ServiceError>, Never>
}

class IPGeoLocationServiceClient: ServiceClient, IPGeoLocationServiceClientProtocol {
    
    func getIP() -> AnyPublisher<Result<IPLocation, ServiceError>, Never> {
        
        let endPoint = "http://ip-api.com/json/"
        
        //let requestModifier: RequestModifier = { request, idToken in request.acceptingJSON(idToken: idToken) }
        let requestModifier: RequestModifier = { request.acceptingJSON() }

        return get(endpoint: endPoint, requestModifier: requestModifier)
            .unwrapResultJSONFromAPI()
            .map(\.data)
            //.decodeFromJson(GetDownloadFile.self)
            .decodeFromJson(IPLocation.self)
            .receive(on: DispatchQueue.main)
            .map(Result.success)
            .catch { error in
                Just(.failure((error as? ServiceError) ?? .failedGetRequest))
            }
            .eraseToAnyPublisher()
    }
    
    
//    private let coachingV1Endpoint = "coaching/api/v1/salesforce/"
//    private let coachingV2Endpoint = "coaching/api/v2/salesforce/"
//    
//    func getAllConsent() -> AnyPublisher<Result<AllConsent, ServiceError>, Never> {
//        let requestModifier: RequestModifier = { request, idToken in request.sendingJSON(idToken: idToken) }
//        
//        return get(
//            endpoint: coachingV1Endpoint + "all-consent/\(UserAttributes.shared.pimId)",
//            requestModifier: requestModifier
//        )
//        .unwrapResultJSONFromAPI()
//        .map(\.data)
//        .decodeFromJson(AllConsent.self)
//        .receive(on: DispatchQueue.main)
//        .map(Result.success)
//        .catch { error in
//            Just(.failure((error as? ServiceError) ?? .failedGetRequest))
//        }
//        .eraseToAnyPublisher()
//    }
    
    
}
