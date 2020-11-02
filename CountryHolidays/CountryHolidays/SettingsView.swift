//
//  SettingsView.swift
//  CountryHolidays
//
//  Created by Chaithra Pabbathi on 10/29/20.
//

import Combine
import SwiftUI
import UIKit

struct SettingsView: View {
    @State private var countries = [Country]()
    
    @AppStorage(Constants.userDefaultsCountryCode) private var countryCode: String = Constants.countryCode
    @AppStorage(Constants.userDefaultsCalendarYear) private var calendarYear: String = Constants.currentCalendarYear
    
    @State private var userChosenCountryCode = UserDefaults.standard.string(forKey: Constants.userDefaultsCountryCode) ?? Constants.userDefaultsCountryCode
    @State private var userChosenCalendarYear = UserDefaults.standard.string(forKey: Constants.userDefaultsCalendarYear) ?? Constants.currentCalendarYear
    
    @State private var cancellableCountries: AnyCancellable?
    
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Country")) {
                    Picker("Select your country", selection: $userChosenCountryCode) {
                        ForEach(0 ..< countries.count, id: \.self) { index in
                            Text(countries[index].name)
                                .tag(countries[index].code)
                        }
                    }
                }
                
                Section(header: Text("Calendar Year")) {
                    TextField("Calendar Year", text: $userChosenCalendarYear)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button("Cancel", action: closeSheet)
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button("Save", action: saveUserInput)
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            let formatter = NumberFormatter()
            formatter.numberStyle = .none
            
            return Alert(title: Text("Invalid Calendar Year"),
                         message: Text("Year needs to be between \(formatter.string(from: NSNumber(value: Constants.minYear))!) and \(formatter.string(from: NSNumber(value: Constants.maxYear))!)"),
                         dismissButton: .cancel())
        })
        .onAppear(perform: loadCountries)
    }
    
    fileprivate func closeSheet() {
        presentationMode.wrappedValue.dismiss()
    }
    
    fileprivate func saveUserInput() {
        
        if let intYear = Int(userChosenCalendarYear) {
            if intYear > Constants.maxYear || intYear < Constants.minYear {
                showAlert = true
                return
            }
        }
        
        countryCode = userChosenCountryCode
        calendarYear = userChosenCalendarYear
        
        presentationMode.wrappedValue.dismiss()
    }
    
    func loadCountries() {
        if let url = URL(string: "https://calendarific.com/api/v2/countries?api_key=\(API_KEY)") {
            
            cancellableCountries = URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: Countries.self, decoder: JSONDecoder())
                .sink { (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(" ERROR: \(error.localizedDescription)")
                    }
                } receiveValue: { countriesFromPublisher in
                    countries = countriesFromPublisher.response.countries
                }
        } else {
            print(" Unable to reach the endpoint")
        }
        
        print("Returning from loadCountries")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
