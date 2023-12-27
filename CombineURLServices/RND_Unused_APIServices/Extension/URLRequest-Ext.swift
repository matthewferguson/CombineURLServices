

import Foundation
//
//extension URLRequest {
//        
//    func addingBearerAuthorization(idToken: String) -> URLRequest {
//        var request = self
//        request.setValue("Bearer \(String(describing: idToken))", forHTTPHeaderField: "Authorization")
//        return request
//    }
//
//    func acceptingJSON(idToken: String) -> URLRequest {
//        var request = self
//        request.setValue("Bearer \(String(describing: idToken))", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        return request
//    }
//    
//    func acceptingJSON() -> URLRequest {
//        var request = self
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        return request
//    }
//    
//    func sendingJSON(idToken: String) -> URLRequest {
//        var request = self
//        request.setValue("Bearer \(String(describing: idToken))", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        return request
//    }
//    
//}
