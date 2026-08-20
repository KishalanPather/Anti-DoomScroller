//
//  AuthorisationView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/20.
//

import SwiftUI


struct AuthorisationView: View{
    @Environment(AuthorisationManager.self) var authorisationManager
    var body: some View {
        
        Text("Authorisation Page")
        
        Button("Request Authorisation"){
            Task{
                await authorisationManager.requestAuthorisation()
            }
        }
        
    }
}
