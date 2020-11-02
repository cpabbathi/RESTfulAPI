//
//  Countries.swift
//  CountryHolidays
//
//  Created by Chaithra Pabbathi on 10/29/20.
//

import Foundation

struct Countries: Decodable {
    var response: CountryResponse
}

struct CountryResponse: Decodable {
    var countries: [Country]
}

struct Country: Decodable {
    var name: String
    var code: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "country_name"
        case code = "iso-3166"
    }
}
