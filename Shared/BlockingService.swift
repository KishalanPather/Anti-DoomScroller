//
//  BlockingService.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/13.
//

import FamilyControls
import ManagedSettings
import DeviceActivity
import Foundation

final class BlockingService {
    let store = ManagedSettingsStore()

    //start blocking
    func startBlocking(selection:FamilyActivitySelection) {
        if selection.applicationTokens.isEmpty && selection.categoryTokens.isEmpty {
            print("No apps to be blocked.")
                    
            // Optional: Clear existing shields if the selection is empty
            store.shield.applications = nil
            store.shield.applicationCategories = nil
            return
        }
                
        store.shield.applications = selection.applicationTokens
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(selection.categoryTokens)
        print("Blocking successfully applied")
    }
    



    func stopBlocking() {
        //store.shield.applications = nil
        //store.shield.applicationCategories = nil
        store.clearAllSettings()
        print("Blocking removed.")
        
    }
    
}
