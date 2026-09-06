//
//  TimerView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/09/05.
//

import SwiftUI

struct TimerView: View{
    
    var body: some View {
        Text(AppGroupStateStore.shared.restrictionEndsAt, style: .timer)
            .font(.title)
        
    }
}

#Preview {TimerView()}
