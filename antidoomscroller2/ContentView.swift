//
//  ContentView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/13.
//

import SwiftUI
import FamilyControls


struct ContentView: View {
    let blockingService = BlockingService()
    let monitoringService = MonitoringService()
    @State private var isBlocking = false
    @State var selection = FamilyActivitySelection()
    @State private var showingPicker = false
    
    var body: some View {
        VStack{
            Text("App Blocker MVP")
                 .font(Font.largeTitle)
                 
            
            Button("Choose Apps") {
                Task {
                    await blockingService.requestAuthorization()
                    showingPicker = true
                    }
                }
                .familyActivityPicker(
                    isPresented: $showingPicker,
                    selection: $selection
                )
                .buttonStyle(.bordered)
            
            Button(isBlocking ? "Unblock" : "Block"){
                if (!isBlocking){
                    //blockingService.startBlocking(selection:selection)
                    monitoringService.startMonitoring(selection:selection)
                    isBlocking = true
                } else{
                    blockingService.stopBlocking()
                    isBlocking = false
                }
                
            }
                .buttonStyle(.borderedProminent)
            
            }
        
                
            
        }
       
    }


#Preview {  ContentView() }
