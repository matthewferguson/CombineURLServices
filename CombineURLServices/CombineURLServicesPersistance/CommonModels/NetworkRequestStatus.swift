//
//  NetworkRequestStatus.swift
//  CombineURLServices
//
//  Created by Matthew Ferguson
//

import Foundation


//type Int64 for use with Core Data
enum NetworkRequestStatus: Int64 {
    case initState  = 1,
         submittal = 2,
         failedNetwork = 3,
         networkError  = 4,
         success = 5,
         delete = 6
}
