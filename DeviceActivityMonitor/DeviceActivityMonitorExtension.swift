//
//  DeviceActivityMonitorExtension.swift
//  DeviceActivityMonitor
//
//  Created by Kishalan Pather on 2026/08/13.
//

import DeviceActivity
import FamilyControls
import ManagedSettings
import os


// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    
    let blockingService = BlockingService()
    let logger = Logger(subsystem: "com.kish.antidoomscroller2.MonitorExtension", category: "ShieldLogic")
    let sharedDefaults = UserDefaults(suiteName: "group.com.kishalan.antidoomscroller2") ?? UserDefaults.standard
    
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        // Handle the start of the interval.
        if activity == DeviceActivityName("LockoutPeriod") {
            logger.notice("intervalDidStart() fired, lockout period monitoring started.")
        }
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
        if activity == DeviceActivityName("LockoutPeriod"){
            blockingService.stopBlocking()
            logger.notice("intervalDidEnd() callback fired, lockout period ended")
            //AppGroupStateStore.shared.setAppState(AppState.inactive)
            sharedDefaults.set(AppState.inactive.rawValue,forKey:"AppStateTest")
            
            
        }
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        if event.rawValue.hasPrefix("ScrollLimitReached"){
            blockingService.startBlocking(selection: AppGroupStateStore.shared.getSelectedApps()!)
            MonitoringService.startMonitorLockoutPeriod()
            
            logger.notice("Threshold reached for event: \(event.rawValue)")
            
        }
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}
