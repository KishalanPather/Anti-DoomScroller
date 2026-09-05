//
//  TimerView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/09/05.
//

import SwiftUI

struct TimerView: View{
    
    func getDate() -> Date{
        var components = DateComponents()
        components.year = 2026
        components.month = 9
        components.day = 5
        components.hour = 21  // Use 24-hour format (10 AM)
        components.minute = 0
        
        let calendar = Calendar.current
        guard let specificDate = calendar.date(from: components) else { return Date() }
        return specificDate
        
    }
    
    
    var body: some View {
        

        
        let today = Date()
        let twoHoursFromNow = Calendar.current.date(byAdding: .minute, value: 120, to: getDate())!
        Text(getDate(), style: .timer)
            .font(.title)
    }
}

#Preview {TimerView()}
