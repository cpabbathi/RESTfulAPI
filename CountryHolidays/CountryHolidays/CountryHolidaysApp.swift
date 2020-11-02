//
//  CountryHolidaysApp.swift
//  CountryHolidays
//
//  Created by Chaithra Pabbathi on 10/27/20.
//

import SwiftUI

@main
struct CountryHolidaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
