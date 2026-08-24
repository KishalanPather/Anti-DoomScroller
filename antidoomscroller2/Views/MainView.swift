//
//  MainView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/22.
//

import SwiftUI

struct MainView: View{
    @State private var showingConfigureBlocking = false
    @State private var appState = AppState.inactive //will have to load from appgroup later
    
    private let monitoringService = MonitoringService()
    
    var body: some View {
        Text("Main View")
        
        if appState == .inactive{
            Text("State: Inactive")
        } else if appState == .monitoring {
            Text("State: Monitoring")
        }else if appState == .restricted {
            Text("State: Restricted")
        }
        
        Button("Configure Blocking Settings"){
            showingConfigureBlocking = true
        }
        .sheet(isPresented: $showingConfigureBlocking){
            ConfigureBlockingView()
        }
            .buttonStyle(.borderedProminent)
        
        Button("Activate monitoring"){
            monitoringService.startMonitorScrollLimit()
        }
            .buttonStyle(.borderedProminent)
        
        Button("Stop monitoring (test purposes)"){
            monitoringService.stopMonitorScrollLimit()
        }
            .buttonStyle(.borderedProminent)
    }
}


#Preview {MainView()}
