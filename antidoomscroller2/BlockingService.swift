//
//  BlockingService.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/13.
//

import FamilyControls
import ManagedSettings
import Foundation

final class BlockingService {
    let store = ManagedSettingsStore()

    func startBlocking(selection: FamilyActivitySelection) {
        print("App blocked.")
        store.shield.applications = selection.applicationTokens
        
    }

    func stopBlocking() {
        print("App unblocked.")
        store.shield.applications = nil
    }
    
    func requestAuthorization() async {
        let center = AuthorizationCenter.shared
        do {
            try await center.requestAuthorization(for: .individual)
            print("Authorisation successful")
        } catch {
            print ("Authorisation failed \(error)")
            }
        }
    
    
}
