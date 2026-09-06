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
                    StatusCardView()
                    SettingsCardView(showingConfigureBlocking: $showingConfigureBlocking)
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

    
    
}

#Preview {
    MainView()
}
