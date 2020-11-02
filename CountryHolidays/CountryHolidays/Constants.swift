//
//  Constants.swift
//  CountryHolidays
//
//  Created by Chaithra Pabbathi on 10/29/20.
//

import Foundation

struct Constants {
    static let monthNames = ["", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    static var abbreviatedMonthNames: [String] {
        monthNames.map { month in
            "\(month.prefix(1))".uppercased()
        }
    }
    
    static let maxYear = 2049
    static let minYear = 1920
    
    static let userDefaultsCountryCode = "countryCode"
    static let userDefaultsCalendarYear = "calendarYear"
    
    static let countryCode = String(Locale.current.regionCode?.suffix(2) ?? "US")
    static let currentCalendarYear = String(Calendar.current.component(.year, from: Date()))
}
