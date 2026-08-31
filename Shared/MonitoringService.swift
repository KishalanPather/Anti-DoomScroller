//
//  MonitoringService.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/15.
//

import FamilyControls
import DeviceActivity
import Foundation
import os

class MonitoringService{
    static let center = DeviceActivityCenter()
    
    private init(){}
    
    static func startMonitorScrollLimitWithIntervals(){
        let logger = Logger(subsystem: "com.kish.antidoomscroller2.MonitorExtension", category: "ShieldLogic")
        let selection = AppGroupStateStore.shared.getSelectedApps()
        let scrollLimit = 1 //AppGroupStateStore.shared.getScrollLimit()
        let cycleHours = 2 // The length of the repeating window, will be default 2 hours for now.
        
        center.stopMonitoring() //Clear any existing monitoring before this starts
        
        let event = DeviceActivityEvent(
            applications: selection!.applicationTokens,
            categories: selection!.categoryTokens,
            threshold: DateComponents(minute: scrollLimit)
        )
        
        let totalBlocks = 24 / cycleHours //How many blocks fit in a day
        
        for i in 0..<totalBlocks{
            let startHour = i * cycleHours
            let endHour = (startHour + cycleHours) - 1 //to prevent overlap. E.g. a 2-hour cycle starts at 00:00 to 01:59
            
            let schedule = DeviceActivitySchedule(
                intervalStart: DateComponents(hour: startHour, minute: 0),
                intervalEnd: DateComponents(hour: endHour, minute: 59),
                repeats: true // Automatically loops these exact blocks tomorrow
            )
            
            // Give each schedule and event a unique identifier
            let scheduleName = DeviceActivityName("cycleHour_\(i)")
            let eventName = DeviceActivityEvent.Name("ScrollLimitReached_\(i)")
            
            do {
                try center.startMonitoring(
                scheduleName,
                during: schedule,
                events: [eventName: event]
                )
            print("Successfully started \(totalBlocks) micro-schedules.")
            logger.notice("Successfully started \(totalBlocks) micro-schedules.")
            } catch {
            print("Failed to start block \(i): \(error)")
            logger.notice("Failed to start block \(i): \(error)")
            }
        }
    }
    
    
    static func startMonitorScrollLimit() {

        let selection = AppGroupStateStore.shared.getSelectedApps()
        //let scrollLimit = AppGroupStateStore.shared.getScrollLimit()
           
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
            threshold: DateComponents(second: 1) // 1 second! using 1 sec for testing purposes
            )
               
            // 4. Start monitoring with BOTH the schedule and the event
            do {
                try center.startMonitoring(
                    activityName,
                    during: schedule,
                    events: [eventName: event] // Pass the event here!
                )
                print("Scroll limit monitoring started.")
            } catch {
                print("Error starting scroll limit monitoring. Error: \(error)")
            }
        }

    static func stopMonitorScrollLimit(){
        center.stopMonitoring()
        print("All monitoring stopped.")
        
    }
    
    static func startMonitorLockoutPeriod(){
        let logger = Logger(subsystem: "com.kish.antidoomscroller2.MonitorExtension", category: "ShieldLogic")
        logger.notice("startMonitorLockoutPeriod() Started")
        //let cooldownPeriod = AppGroupStateStore.shared.getLockoutPeriod()
        let activityName = DeviceActivityName("LockoutPeriod")
        
        let now = Date()
        let endPeriod = Date().addingTimeInterval(15 * 60) //setting is to 15 min for testing purposes

        let startComponent = Calendar.current.dateComponents([.hour, .minute], from: now)
        let endComponent = Calendar.current.dateComponents([.hour, .minute], from: endPeriod)

        let schedule = DeviceActivitySchedule(
            intervalStart: startComponent,
            intervalEnd: endComponent,
            repeats: false
        )
            
        do {
        try center.startMonitoring(activityName, during: schedule)
        print("Lockout period monitoring started")
            logger.notice("startMonitorLockoutperiod() is monitoring successfully")
        } catch {
        print("Failed to start lockout period monitoring: \(error)")
            logger.notice("startMonitorLockoutperiod() is NOT monitoring. Unsuccessful. Error: \(error)")
        }
    }
}
    
    

