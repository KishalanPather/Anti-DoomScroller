//
//  ContentView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/13.
//

import SwiftUI
import FamilyControls


struct ContentView: View {
    @State private var authorisationManager = AuthorisationManager()

    var body: some View {
        VStack{
            if authorisationManager.checkAuthorisation(){
                MainView()
            }else {
                AuthorisationView()
                    .environment(authorisationManager)
                }
            }
            
        }
       
    }


#Preview {  ContentView() }
