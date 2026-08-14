//
//  ContentView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/13.
//

import SwiftUI

struct ContentView: View {
    let blockingService = BlockingService()
    //@State private var isBlocking = false
    
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
                    do {
                        try await blockingService.requestAuthorization()
                    } catch {
                        print(error)
                    }
                }
            }
                
            
        }
       
    }
}

#Preview {
    ContentView()
}
