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
        
        let newDate = Calendar.current.date(byAdding: .minute, value: 120, to: specificDate)!
        return newDate
        
    }
    
    func calculateRestrictionEnd() -> Date {
        let newDate = Calendar.current.date(byAdding: .minute, value: 120, to: AppGroupStateStore.shared.restrictionStartsAt)!
        AppGroupStateStore.shared.restrictionEndsAt = newDate
        return newDate
    }
    
    
    
    var body: some View {
        Text(AppGroupStateStore.shared.restrictionEndsAt, style: .timer)
            .font(.title)
        
        Text(" starts at: \(AppGroupStateStore.shared.restrictionStartsAt)")
        Text(" ends at: \(AppGroupStateStore.shared.restrictionEndsAt)")
    }
}

#Preview {TimerView()}
