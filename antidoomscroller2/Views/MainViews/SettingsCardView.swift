//
//  SettingsCardView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/09/06.
//

import SwiftUI

struct SettingsCardView: View{
    @Binding var showingConfigureBlocking: Bool
    
    private func statBox(title: String, value: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(UIColor.tertiarySystemGroupedBackground))
        .cornerRadius(12)
    }
    
    
    
    var body: some View{
        VStack(alignment: .leading, spacing: 16) {
            Text("Current Settings")
                .font(.headline)
            
            HStack(spacing: 16) {
                statBox(
                    title: "Scroll Limit",
                    value: "\(AppGroupStateStore.shared.scrollLimit) min",
                    icon: "arrow.up.and.down"
                )
                
                statBox(
                    title: "Lockout",
                    value: "\(AppGroupStateStore.shared.lockoutPeriod) min",
                    icon: "lock.fill"
                )
            }
            
            Button {
                showingConfigureBlocking = true
            } label: {
                Label("Configure Blocking", systemImage: "slider.horizontal.3")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .controlSize(.large)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}
