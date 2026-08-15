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
    //@State private var isBlocking = false
    @State var selection = FamilyActivitySelection()
    @State private var showingPicker = false
    
    var body: some View {
        VStack{
            Text("App Blocker MVP")
                 .font(Font.largeTitle)
                 
            
            Button("Block"){
                print("Block button pressed")
                blockingService.startBlocking()
            }
                .buttonStyle(.borderedProminent)
            
            Button("Authorize") {
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
            
            Button("Test blocking"){
                blockingService.testBlockingOn(selection: selection)
            }
            }
        
                
            
        }
       
    }


#Preview {
    ContentView()
}
