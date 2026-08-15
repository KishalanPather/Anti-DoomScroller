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
           
           let event = DeviceActivityEvent(
               applications: selection.applicationTokens,
               threshold: DateComponents(minute: 1)
           )
           
           let schedule = DeviceActivitySchedule(
               intervalStart: DateComponents(hour: 0, minute: 0),
               intervalEnd: DateComponents(hour: 23, minute: 59),
               repeats: true
           )
           
           try? center.startMonitoring(
               .init("AppMonitoring"),
               during: schedule,
               events: [
                   .init("OneMinuteEvent"): event
               ]
           )
       }
    
    
}
