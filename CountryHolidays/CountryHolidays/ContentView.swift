//
//  ContentView.swift
//  CountryHolidays
//
//  Created by Chaithra Pabbathi on 10/27/20.
//

import Combine
import SwiftUI

struct ContentView: View {
    @State var searchString = ""
    @State private var holidays = [Holiday]()
    @State private var cancellable: AnyCancellable?
    
    let fontSize: CGFloat = 15
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchString: $searchString)
                
                ScrollViewReader { proxy in
                    List {
                        ForEach(1 ..< 13, id: \.self) { monthID in
                            Section(header: Text(Constants.monthNames[monthID])) {
                                ForEach(0 ..< holidays.count, id: \.self) { index in
                                    if holidays[index].date.dateTime.month == monthID &&
                                        (searchString == "" ||
                                            holidays[index].name.lowercased().contains(searchString.lowercased()) || holidays[index].description.lowercased().contains(searchString.lowercased())){
                                        NavigationLink(
                                            destination: HolidayDetail(holiday: holidays[index]),
                                            label: {
                                                HStack {
                                                    Image(systemName: "\(holidays[index].date.dateTime.day).circle.fill")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                    VStack(alignment: .leading) {
                                                        Text(holidays[index].name)
                                                        Text(holidays[index].description)
                                                            .font(.caption)
                                                            .foregroundColor(.secondary)
                                                    }
                                                }
                                            })
                                    }
                                }
                            }
                            .id("month\(monthID)")
                        }
                    }
                    
                    HStack(spacing: 14) {
                        ForEach(1 ..< 13, id: \.self) { monthID in
                            Button {
                                proxy.scrollTo("month\(monthID)", anchor: .top)
                            } label: {
                                Text(Constants.abbreviatedMonthNames[monthID])
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Holidays")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: loadHolidays)
        }
    }
    
    func loadHolidays() {
        guard let url = URL(string: "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=IN&year=2020")
        else {
            print("URL is not legitimate")
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { (data: Data, response: URLResponse) -> Data in
                    return data
                }
                .decode(type: HolidayResponse.self, decoder: JSONDecoder())
                .sink { (completion) in
                    switch completion {
                    case .finished:
                        print("Successfully received the list of holidays")
                    case .failure(let error):
                        fatalError("Received an error while fetching the list of Holidays: \(error.localizedDescription)")
                    }
                } receiveValue: { response in
                    holidays = response.response.holidays.sorted(by: { (first, second) -> Bool in
                        first.date.fullDate < second.date.fullDate
                    })
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
