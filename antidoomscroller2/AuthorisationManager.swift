//
//  AuthorisationManager.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/20.
//

import FamilyControls
import Observation

@Observable
class AuthorisationManager{
    
    private var isAuthorised = false
    private let center = AuthorizationCenter.shared
    
    func checkAuthorisation() -> Bool{
        switch center.authorizationStatus {
        case .approved:
            isAuthorised = true
            
        case .notDetermined:
            isAuthorised = false
            
        case .denied:
            isAuthorised = false
        default:
            isAuthorised = false
            print("Undefined authorisation statement received.")
        }
        return isAuthorised
        
    }
    
    
    func requestAuthorisation() async {
        do {
            try await center.requestAuthorization(for: .individual)
            print("Authorisation successful")
        } catch {
            print ("Authorisation failed \(error)")
            }
        }
    
    
}
