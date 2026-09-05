//
//  MainView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/22.
//

import SwiftUI

struct MainView: View{
    @State private var showingConfigureBlocking = false
    
    private var appState = AppGroupStateStore.shared.appState
    private var scrollLimit = AppGroupStateStore.shared.scrollLimit
    private var lockoutPeriod = AppGroupStateStore.shared.lockoutPeriod
      
    
    var body: some View {
        Text("Main View")
        
        if AppGroupStateStore.shared.appState == .inactive{
            Text("State: Inactive")
        } else if AppGroupStateStore.shared.appState == .monitoring {
            Text("State: Monitoring")
        }else if AppGroupStateStore.shared.appState == .restricted {
            Text("State: Restricted")
        }
        
        VStack{
            //  Display the result using the state variable
            Text("Scroll Limit: \(AppGroupStateStore.shared.scrollLimit)")
            .font(.headline)
            
            Text("Lockout Period: \(AppGroupStateStore.shared.lockoutPeriod)")
            .font(.headline)
        }
        
        Button("Configure Blocking Settings"){
            showingConfigureBlocking = true
        }
        .sheet(isPresented: $showingConfigureBlocking){
            ConfigureBlockingView()
        }
            .buttonStyle(.borderedProminent)
        
        Button("Activate monitoring"){
            MonitoringService.startMonitorScrollLimitWithIntervals()
        }
            .buttonStyle(.borderedProminent)
        
        Button("Show app Group state (testing)"){
            print(AppGroupStateStore.shared.defaults.integer(forKey: "scrollLimit"))
            print(AppGroupStateStore.shared.defaults.integer(forKey: "lockoutPeriod"))
    
            
        }
        
        Button("Stop monitoring (test purposes)"){
            MonitoringService.stopMonitorScrollLimit()
        }
            .buttonStyle(.borderedProminent)
    }
}


#Preview {MainView()}
