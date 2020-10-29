//
//  Holidays.swift
//  CountryHolidays
//
//  Created by Chaithra Pabbathi on 10/28/20.
//

import Foundation

struct HolidayDateTime: Decodable {
    var year: Int
    var month: Int
    var day: Int
    
    var monthName: String {
        Constants.monthNames[month]
    }
}

struct HolidayDate: Decodable {
    var fullDate: String
    var dateTime: HolidayDateTime
    
    private enum CodingKeys: String, CodingKey {
        case fullDate = "iso"
        case dateTime = "datetime"
    }
}

struct HolidayState: Decodable {
    var name: String
}

struct Holiday: Decodable {
    var name: String
    var description: String
    var date: HolidayDate
    var type: [String]
    var locations: String
    var states: [HolidayState]
    var stateList: String {
        states.reduce("") { (partialResult, holidayState) in
            if partialResult == "" {
                return holidayState.name
            } else {
                return partialResult + ", " + holidayState.name
            }
        }
    }
    
    private enum CodingKeys: CodingKey {
        case name, description, date, type, locations, states
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            name = try container.decode(String.self, forKey: .name)
            description = try container.decode(String.self, forKey: .description)
            date = try container.decode(HolidayDate.self, forKey: .date)
            type = try container.decode([String].self, forKey: .type)
            locations = try container.decode(String.self, forKey: .locations)
            
            do {
                let singleState = try container.decode(String.self, forKey: .states)
                states = [HolidayState(name: singleState)]
            } catch {
                states = try container.decode([HolidayState].self, forKey: .states)
            }
        }
    }
    
    init(name: String, description: String, date: HolidayDate, type: [String], locations: String, states: [HolidayState]) {
        self.name = name
        self.description = description
        self.date = date
        self.type = type
        self.locations = locations
        self.states = states
    }
    
    static var example: Holiday =  Holiday(name: "Example Day", description: "This is an example holiday", date: HolidayDate(fullDate: "2020-01-01", dateTime: HolidayDateTime(year: 2020, month: 1, day: 1)), type: ["Generic Holiday"], locations: "IL", states: [HolidayState(name: "Illinois")])
}

struct Holidays: Decodable {
    var holidays: [Holiday]
}

struct HolidayResponse: Decodable {
    var response: Holidays
}
