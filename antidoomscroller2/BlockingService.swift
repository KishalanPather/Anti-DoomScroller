//
//  BlockingService.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/13.
//

import FamilyControls
import ManagedSettings

final class BlockingService {

    func startBlocking() {
        // Start blocking
        print("App has initiated blocking")
    }

    func stopBlocking() {
        // Stop blocking
    }
    
    func requestAuthorization() async throws {
            try await AuthorizationCenter.shared.requestAuthorization(
                for: .individual    
            )
        }
}
