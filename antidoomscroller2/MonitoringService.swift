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
    let center = DeviceActivityCenter()
       
       func startMonitoring(selection: FamilyActivitySelection) {
           
           // 1. Save the selection so the extension can see it later
               selection.saveToAppGroup()
               
               let center = DeviceActivityCenter()
               let activityName = DeviceActivityName("DailyAppLimit")
               let eventName = DeviceActivityEvent.Name("HitOneMinute")
               
               // 2. Define the 24-hour window where we track time
               let schedule = DeviceActivitySchedule(
                   intervalStart: DateComponents(hour: 0, minute: 0),
                   intervalEnd: DateComponents(hour: 23, minute: 59),
                   repeats: true
               )
               
               // 3. Define the actual 1-minute limit tied to their selected apps
               let event = DeviceActivityEvent(
                   applications: selection.applicationTokens,
                   categories: selection.categoryTokens,
                   webDomains: selection.webDomainTokens,
                   threshold: DateComponents(minute: 1) // 1 minute!
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
}
    
    

