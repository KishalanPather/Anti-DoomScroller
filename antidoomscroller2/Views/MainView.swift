//
//  MainView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/22.
//

import SwiftUI

struct MainView: View{
    @State private var showingConfigureBlocking = false
    @State private var appState = AppGroupStateStore.shared.getAppState()
    
    @AppStorage("AppStateTest", store: UserDefaults(suiteName: "group.com.kishalan.antidoomscroller2"))
    var isAppState:AppState = .inactive
    
    @AppStorage("scrollLimitTest", store: UserDefaults(suiteName: "group.com.kishalan.antidoomscroller2"))
    var scrollLimit: Int = 0
    
    @AppStorage("LockoutPeriodTest", store: UserDefaults(suiteName: "group.com.kishalan.antidoomscroller2"))
    var lockoutPeriod: Int = 0
      
    
    var body: some View {
        Text("Main View")
        
        if isAppState == .inactive{
            Text("State: Inactive")
        } else if isAppState == .monitoring {
            Text("State: Monitoring")
        }else if isAppState == .restricted {
            Text("State: Restricted")
        }
        
        VStack{
            //  Display the result using the state variable
            Text("Scroll Limit: \(scrollLimit)")
            .font(.headline)
            
            Text("Lockout Period: \(lockoutPeriod)")
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
            print(AppGroupStateStore.shared.getScrollLimit())
            print(AppGroupStateStore.shared.getLockoutPeriod())
            
        }
        
        Button("Stop monitoring (test purposes)"){
            MonitoringService.stopMonitorScrollLimit()
        }
            .buttonStyle(.borderedProminent)
    }
}


#Preview {MainView()}
