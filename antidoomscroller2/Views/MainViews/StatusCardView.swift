//
//  StatusCardView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/09/06.
//

import SwiftUI

struct StatusCardView: View{
    // MARK: - State Helpers
    
    //private var statusIcon = "moon.zzz.fill"
    
    private var statusIcon: String {
        switch AppGroupStateStore.shared.appState {
        case .inactive: return "moon.zzz.fill"
        case .monitoring: return "eye.fill"
        case .restricted: return "lock.shield.fill"
        //default: return "questionmark.circle"
        }
    }
    
    private var statusText: String {
        switch AppGroupStateStore.shared.appState {
        case .inactive: return "Inactive"
        case .monitoring: return "Monitoring"
        case .restricted: return "Restricted"
        //default: return "Unknown"
        }
    }
    
    private var statusColor: Color {
        switch AppGroupStateStore.shared.appState {
        case .inactive: return .gray
        case .monitoring: return .green
        case .restricted: return .red
        //default: return .primary
        }
    }
    
    var body: some View{
        VStack(spacing: 16) {
            HStack {
                Image(systemName: statusIcon)
                    .font(.system(size: 32))
                    .foregroundColor(statusColor)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("App State")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(statusText)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(statusColor)
                }
                Spacer()
            }
            
            // Only show the timer if we are restricted
            if AppGroupStateStore.shared.appState == .restricted {
                Divider()
                HStack {
                    Image(systemName: "timer")
                        .foregroundColor(.red)
                    TimerView()
                    Spacer()
                }
                .padding(.top, 4)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    StatusCardView()
}
