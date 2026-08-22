//
//  AppGroupStateStore.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/20.
//

import Foundation
import FamilyControls

final class AppGroupStateStore {
    private let appGroupID = "group.com.kishalan.antidoomscroller2"
    private let defaults:UserDefaults
    
    private enum Keys{
            static let selectedApps = "selectedApps"
    }
    
    
    
    init() {
            guard let defaults = UserDefaults(suiteName: appGroupID)
        else {
                fatalError("Could not access App Group UserDefaults")
            }
            self.defaults = defaults
        }
    
    
    func saveSelectedApps(_ selection:FamilyActivitySelection){
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
    
    func saveAppState(){}
        
    func getAppState(){}
        
    func saveScrollLimit (){}
        
    func getScrollLimit(){}
        
    func setLockoutPeriod(){}
        
    func getLockoutPeriod(){}
        
    func setRestrictionEndsAt(){}
        
    func getRestrictionEndsAt(){}
    
    
    
    
}
