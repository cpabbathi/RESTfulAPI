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
}
