//
//  HolidayDetail.swift
//  CountryHolidays
//
//  Created by Chaithra Pabbathi on 10/29/20.
//

import SwiftUI

struct HolidayDetail: View {
    var holiday: Holiday
    var date: String {
        let components = DateComponents(year: holiday.date.dateTime.year, month: holiday.date.dateTime.month, day: holiday.date.dateTime.day)
        if let date = Calendar.current.date(from: components) {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: date)
        }
        
        return ""
    }
    
    var body: some View {
        VStack {
            Text(holiday.name)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
            Text(date)
                .font(.title3)
                .foregroundColor(Color.black.opacity(0.9))
                .fontWeight(.medium)
            Text(holiday.description)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.top, 8)
                .padding(.bottom)
            HStack {
                Text("Type:")
                    .fontWeight(.medium)
                
                Text(holiday.type.joined(separator: ", "))
            }
            HStack {
                Text("State:")
                    .fontWeight(.medium)
                
                Text(holiday.stateList)
            }
        }
        .padding(30)
        .background(RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(Color.black.opacity(0.05)))
        .padding(10)
    }
}

struct HolidayDetail_Previews: PreviewProvider {
    static var previews: some View {
        HolidayDetail(holiday: Holiday.example)
    }
}
