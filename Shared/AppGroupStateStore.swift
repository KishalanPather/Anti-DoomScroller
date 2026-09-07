//
//  AppGroupStateStore.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/20.
//

import Foundation
import FamilyControls
import Observation
import UIKit

@Observable
final class AppGroupStateStore {
    static let shared = AppGroupStateStore()
    
    @ObservationIgnored private let appGroupID = "group.com.kishalan.antidoomscroller2"
    @ObservationIgnored  let defaults:UserDefaults
    
    private enum Keys {          //uses singleton design pattern
        static let selectedApps = "selectedApps"
        static let scrollLimit = "scrollLimit"
        static let lockoutPeriod = "lockoutPeriod"
        static let appState = "appState"
        static let restrictionStartsAt = "restrictionStartsAt"
        static let restrictionEndsAt = "restrictionEndsAt"
    }
    //All State variables
    var selectedApps: FamilyActivitySelection {
        didSet { setSelectedApps(selectedApps) }
    }
    var appState: AppState {
        didSet{defaults.set(appState.rawValue, forKey: Keys.appState)}
    }
    var scrollLimit: Int {
        didSet{defaults.set(scrollLimit, forKey: Keys.scrollLimit)}
    }
    var lockoutPeriod: Int {
        didSet{defaults.set(lockoutPeriod, forKey: Keys.lockoutPeriod)}
    }
    var restrictionStartsAt: Date {
        didSet{defaults.set(restrictionStartsAt, forKey: Keys.restrictionStartsAt)}
    }
    var restrictionEndsAt: Date {
        didSet{defaults.set(restrictionEndsAt, forKey: Keys.restrictionEndsAt)}
    }
    
    
    private init() {
            guard let defaults = UserDefaults(suiteName: appGroupID)
        else {
            fatalError("Could not access App Group UserDefaults")
            }
            self.defaults = defaults
        
            //Retrive state variables from app group. Set default values if not found
            self.scrollLimit = defaults.integer(forKey: Keys.scrollLimit)
            self.lockoutPeriod = defaults.integer(forKey: Keys.lockoutPeriod)
            self.restrictionStartsAt = defaults.object(forKey: Keys.restrictionStartsAt) as? Date ?? Date()
            self.restrictionEndsAt = defaults.object(forKey: Keys.restrictionEndsAt) as? Date ?? Date()
        
            if let rawValue = defaults.string(forKey: Keys.appState), let state = AppState(rawValue: rawValue) {
                    self.appState = state
            } else {
                self.appState = AppState.inactive
            }
        
            if let data = defaults.data(forKey: Keys.selectedApps),
                   let decoded = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) {
                    self.selectedApps = decoded
            } else {
                self.selectedApps = FamilyActivitySelection()
            }
        
        // Handle views reloading when the user isn't in the app and state changes
        NotificationCenter.default.addObserver(
                forName: UserDefaults.didChangeNotification,
                object: self.defaults, // Only listen to your App Group
                queue: .main
            ) { [weak self] _ in
                self?.syncWithAppGroup()
            }
        
        NotificationCenter.default.addObserver(
                    forName: UIApplication.willEnterForegroundNotification,
                    object: nil,
                    queue: .main
                ) { [weak self] _ in
                    self?.syncWithAppGroup()
                }
        }
    
    
    
     private func setSelectedApps(_ selection:FamilyActivitySelection){
        do{
            let data = try JSONEncoder().encode(selection)
            defaults.set(data, forKey: Keys.selectedApps)
            print("Successfully saved selected apps.")
        }catch{
            print("Failed to save selected apps. Error: \(error)")
        }
    }
    
    //Need a dedicated getter since the complex data type makes it difficult to rely on AppGroupStateStore.shared.selectedApps. Usually just returns stale data
    func getSelectedApps() -> FamilyActivitySelection? {
            guard let data = defaults.data(forKey: Keys.selectedApps) else {
                return nil
            }

            do {
                return try JSONDecoder().decode(FamilyActivitySelection.self,from: data)
                } catch {
                    print("Failed to load selected apps: \(error)")
                    return nil
                }
        }
    
    func getScrollLimit() -> Int {
            return defaults.integer(forKey: Keys.scrollLimit)
        }
    
    func getLockoutPeriod() -> Int {
           return defaults.integer(forKey: Keys.lockoutPeriod)
        }
    
    private func syncWithAppGroup() {
        let newScrollLimit = defaults.integer(forKey: Keys.scrollLimit)
        if scrollLimit != newScrollLimit { scrollLimit = newScrollLimit }
        
        let newLockout = defaults.integer(forKey: Keys.lockoutPeriod)
        if lockoutPeriod != newLockout { lockoutPeriod = newLockout }
        
        let newRestrictionStartsAt = defaults.object(forKey: Keys.restrictionStartsAt)
        if restrictionStartsAt != newRestrictionStartsAt as? Date ?? Date() { restrictionStartsAt = newRestrictionStartsAt as? Date ?? Date() }
        
        let newRestrictionEndsAt = defaults.object(forKey: Keys.restrictionEndsAt)
        if restrictionEndsAt != newRestrictionEndsAt as? Date ?? Date() { restrictionEndsAt = newRestrictionEndsAt as? Date ?? Date() }
        
        if let rawValue = defaults.string(forKey: Keys.appState),
           let state = AppState(rawValue: rawValue),
           appState != state {
            appState = state
        }
        
        //if let incomingData = defaults.data(forKey: Keys.selectedApps) {
        //    // 1. Convert our current memory value into Data for comparison
        //    let currentData = try? JSONEncoder().encode(selectedApps)
            
        //    // 2. Only assign if the bytes are actually different
        //    if incomingData != currentData {
       //         if let decoded = try? JSONDecoder().decode(FamilyActivitySelection.self, from: incomingData) {
       //             selectedApps = decoded
       //         }
       //     }
       // }
    }
    
    
}
