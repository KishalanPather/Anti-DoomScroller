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

    
    /*func startBlocking() {
        if let selection = FamilyActivitySelection.loadFromAppGroup(){
            store.shield.applications = selection.applicationTokens
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(selection.categoryTokens)
            print("Blocking successfully applied")
        } else{
            print("No apps to be blocked.")
        }
    }

    func stopBlocking() {
        //store.shield.applications = nil
        //store.shield.applicationCategories = nil
        store.clearAllSettings()
        print("Blocking removed.")
        
    }
    */
}
