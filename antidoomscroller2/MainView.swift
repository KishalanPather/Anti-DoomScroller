//
//  MainView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/22.
//

import SwiftUI

struct MainView: View{
    @State private var showingConfigureBlocking = false
    
    var body: some View {
        Text("Main View")
        
        Button("Configure Blocking Settings"){
            showingConfigureBlocking = true
        }
        .sheet(isPresented: $showingConfigureBlocking){
            ConfigureBlockingView()
        }
            .buttonStyle(.borderedProminent)
        
        Button("Activate monitoring"){}
            .buttonStyle(.borderedProminent)
    }
}


#Preview {MainView()}
