//
//  AppGroupStateStore.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/20.
//

import Foundation
import FamilyControls
import Observation

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
        static let restrictionEndsAt = "restrictionEndsAt"
    }
    
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
    var restrictionEndsAt: Int {
        didSet{defaults.set(restrictionEndsAt, forKey: Keys.restrictionEndsAt)}
    }
    
    
    private init() {
            guard let defaults = UserDefaults(suiteName: appGroupID)
        else {
            fatalError("Could not access App Group UserDefaults")
            }
            self.defaults = defaults
        
            //set app variables
            self.scrollLimit = defaults.integer(forKey: Keys.scrollLimit)
            self.lockoutPeriod = defaults.integer(forKey: Keys.lockoutPeriod)
            self.restrictionEndsAt = defaults.integer(forKey: Keys.restrictionEndsAt)
        
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
    
    
}
