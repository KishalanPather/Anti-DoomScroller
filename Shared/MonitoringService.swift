//
//  MonitoringService.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/15.
//

import FamilyControls
import DeviceActivity
import Foundation

class MonitoringService{
    static let center = DeviceActivityCenter()
       
       static func startMonitorScrollLimit() {
           
           let selection = AppGroupStateStore.shared.getSelectedApps()
           let scrollLimit = AppGroupStateStore.shared.getScrollLimit()
           
           // 1. Save the selection so the extension can see it later
               //selection.saveToAppGroup()
               let activityName = DeviceActivityName("ScrollLimit")
               let eventName = DeviceActivityEvent.Name("ScrollLimitReached")
               
               // 2. Define the 24-hour window where we track time
               let schedule = DeviceActivitySchedule(
                   intervalStart: DateComponents(hour: 0, minute: 0),
                   intervalEnd: DateComponents(hour: 23, minute: 59),
                   repeats: true
               )
               
               // 3. Define the actual 5-minute limit tied to their selected apps
               let event = DeviceActivityEvent(
                applications: selection!.applicationTokens,
                categories: selection!.categoryTokens,
                webDomains: selection!.webDomainTokens,
                   threshold: DateComponents(minute: 5) // 5 minute!
               )
               
               // 4. Start monitoring with BOTH the schedule and the event
               do {
                   try center.startMonitoring(
                       activityName,
                       during: schedule,
                       events: [eventName: event] // Pass the event here!
                   )
                   print("Monitoring started!")
               } catch {
                   print("Error starting monitor: \(error)")
               }
           }
    
    static func stopMonitorScrollLimit(){
        center.stopMonitoring()
        print("All monitoring stopped.")
        
    }
    
    static func startMonitorLockoutPeriod(){
        let cooldownPeriod = AppGroupStateStore.shared.getLockoutPeriod()
        
        let activityName = DeviceActivityName("LockoutPeriod")

            let now = Calendar.current.dateComponents([.hour, .minute], from: Date())
            let twoHoursFromNow = Calendar.current.dateComponents([.hour, .minute], from: Date().addingTimeInterval(2 * 3600))

            let schedule = DeviceActivitySchedule(
                intervalStart: now,
                intervalEnd: twoHoursFromNow,
                repeats: false
            )
            
            do {
            try center.startMonitoring(activityName, during: schedule)
            print("Lockout Period monitoring started")
            } catch {
            print("Failed to start lockout period monitoring: \(error)")
            }
    }
}
    
    

