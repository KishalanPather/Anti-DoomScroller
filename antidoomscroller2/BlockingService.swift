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

    func startBlocking() {
        // Start blocking
        print("App has initiated blocking")
    }

    func stopBlocking() {
        // Stop blocking
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
