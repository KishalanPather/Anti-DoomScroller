//
//  AppGroupStateStore.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/20.
//

import Foundation
import FamilyControls

final class AppGroupStateStore {
    static let shared = AppGroupStateStore()
    
    private let appGroupID = "group.com.kishalan.antidoomscroller2"
    private let defaults:UserDefaults
    
    private enum Keys{          //uses singleton design pattern
        static let selectedApps = "selectedApps"
        static let scrollLimit = "scrollLimit"
        static let lockoutPeriod = "lockoutPeriod"
        static let appState = "appState"
        static let restrictionEndsAt = "restrictionEndsAt"
    }
    
    
    private init() {
            guard let defaults = UserDefaults(suiteName: appGroupID)
        else {
                fatalError("Could not access App Group UserDefaults")
            }
            self.defaults = defaults
        }
    
    
    func setSelectedApps(_ selection:FamilyActivitySelection){
        do{
            let data = try JSONEncoder().encode(selection)
            defaults.set(data, forKey: Keys.selectedApps)
            print("Successfully saved selected apps.")
        }catch{
            print("Failed to save selected apps. Error: \(error)")
        }
    }
    
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
    
    
    func setAppState(_ appState: AppState){
        defaults.set(appState.rawValue, forKey: Keys.appState)
    }
    
        
    func getAppState() -> AppState? {
        guard let rawValue = defaults.string(forKey: Keys.appState) else {
                return nil
            }
            return AppState(rawValue: rawValue)
    }
        
    func setScrollLimit (_ minutes: Int){
        defaults.set(minutes, forKey: Keys.scrollLimit)
    }
        
    func getScrollLimit() -> Int {
        return defaults.integer(forKey: Keys.scrollLimit)
    }
        
    func setLockoutPeriod(_ lockOutPeriod: Int){
        defaults.set(lockOutPeriod, forKey: Keys.lockoutPeriod)
    }
        
    func getLockoutPeriod() -> Int {
       return defaults.integer(forKey: Keys.lockoutPeriod)
    }
        
    func setRestrictionEndsAt(_ restrictionEnd: Int){
        defaults.set(restrictionEnd, forKey: Keys.restrictionEndsAt)
    }
        
    func getRestrictionEndsAt() -> Int {
        return defaults.integer(forKey: Keys.restrictionEndsAt)
    }
    
    
}
