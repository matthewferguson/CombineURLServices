//
//  IPLocation.swift
//  CombineURLServices
//
//  Matthew Ferguson on 11/13/23.
//

import Foundation

struct IPLocation: Codable { 
    var id: String?
    var status: String?
    var message: String?
    var country: String?
    var countryCode: String?
    var region: String?
    var regionName: String?
    var city: String?
    var zip: String?
    var lat: Double?
    var lon: Double?
    var timezone: String?
    var isp: String?
    var org: String?
    var query: String?
    
    static let error = IPLocation(id: "id", status: "fail", message: "Communication Fail", country: String(), countryCode: String(), region: String(), regionName: String(), city: String(), zip: String(), lat: 0.0, lon: 0.0, timezone: String(), isp: String(), org: String(), query: String())

    public init(id:String = "", status: String = "fail", message:String = "Initialization state", country:String = "", countryCode:String = "", region:String = "", regionName:String = "", city:String = "", zip:String = "", lat: Double = 0.0, lon: Double = 0.0, timezone: String = "", isp: String = "", org: String = "", query: String = "") {
    
        self.id = id
        self.status = status
        self.message = message
        self.country = country
        self.countryCode = countryCode
        self.region = region
        self.regionName = regionName
        self.city = city
        self.zip = zip
        self.lat = lat
        self.lon = lon
        self.timezone = timezone
        self.isp = isp
        self.org = org
        self.query = query
    }
    
 
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case message
        case country
        case countryCode
        case region
        case regionName
        case city
        case zip
        case lat
        case lon
        case timezone
        case isp
        case org
        case query
    }
}

extension IPLocation: CustomDebugStringConvertible {
        public var debugDescription: String {
            return "\nquery:\(String(describing: query)) \nstatus:\(String(describing: status)) \nmessage:\(String(describing: message)) \ncountryCode:\(String(describing: countryCode)) \nregion:\(String(describing: region)) \nregionName:\(String(describing: regionName)) \ncity:\(String(describing: city)) \nzip:\(String(describing: zip)) \nlat:\(String(describing: lat)) \nlon:\(String(describing: lon)) \ntimezone:\(String(describing: timezone)) \nisp:\(String(describing: isp)) \norg:\(String(describing: org))\nid:\(String(describing: id))"
        }
}
