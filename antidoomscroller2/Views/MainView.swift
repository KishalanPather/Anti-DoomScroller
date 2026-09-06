//
//  MainView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/22.
//

import SwiftUI

struct MainView: View {
    @State private var showingConfigureBlocking = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    statusCard
                    settingsCard
                    actionSection
                    debugSection
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground)) // Standard iOS background color
            .navigationTitle("Anti-Doomscroller")
            .sheet(isPresented: $showingConfigureBlocking) {
                ConfigureBlockingView()
            }
        }
    }
    
    // MARK: - UI Components
    
    private var statusCard: some View {
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
    
    private var settingsCard: some View {
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
    
    private var actionSection: some View {
        VStack(spacing: 16) {
            
            if AppGroupStateStore.shared.appState == .restricted{
                Button {
                    print("Cannot activate while already in a restricted state")
                } label: {
                    Label("Activate Monitoring", systemImage: "shield.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.gray)
                .controlSize(.large)
                
                Button {
                    MonitoringService.stopMonitorScrollLimit()
                    print("Cannot stop when in a restricted state")
                } label: {
                    Label("Stop Monitoring", systemImage: "stop.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.gray)
                .controlSize(.large)
            } else{
                
                Button {
                    MonitoringService.startMonitorScrollLimitWithIntervals()
                } label: {
                    Label("Activate Monitoring", systemImage: "shield.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .controlSize(.large)
                
                Button {
                    MonitoringService.stopMonitorScrollLimit()
                } label: {
                    Label("Stop Monitoring", systemImage: "stop.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.red)
                .controlSize(.large)
            }
            
        }
    }
    
    private var debugSection: some View {
        VStack {
            Divider()
                .padding(.vertical)
            
            Button("Print AppGroup State (Debug)") {
                let defaults = AppGroupStateStore.shared.defaults
                print("Scroll Limit: \(defaults.integer(forKey: "scrollLimit"))")
                print("Lockout Period: \(defaults.integer(forKey: "lockoutPeriod"))")
                print("Starts: \(String(describing: defaults.object(forKey: "restrictionStartsAt")))")
                print("Ends: \(String(describing: defaults.object(forKey: "restrictionEndsAt")))")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
    }
    
    // MARK: - State Helpers
    
    private var statusText: String {
        switch AppGroupStateStore.shared.appState {
        case .inactive: return "Inactive"
        case .monitoring: return "Monitoring"
        case .restricted: return "Restricted"
        default: return "Unknown"
        }
    }
    
    private var statusColor: Color {
        switch AppGroupStateStore.shared.appState {
        case .inactive: return .gray
        case .monitoring: return .green
        case .restricted: return .red
        default: return .primary
        }
    }
    
    private var statusIcon: String {
        switch AppGroupStateStore.shared.appState {
        case .inactive: return "moon.zzz.fill"
        case .monitoring: return "eye.fill"
        case .restricted: return "lock.shield.fill"
        default: return "questionmark.circle"
        }
    }
}

#Preview {
    MainView()
}
