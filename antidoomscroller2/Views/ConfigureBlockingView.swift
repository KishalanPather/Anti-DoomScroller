//
//  ConfigureBlockingView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/20.
//

import SwiftUI
import FamilyControls

struct ConfigureBlockingView: View{
    @Environment(\.dismiss) var dismiss //allows the view to be dismissed when form is submitted. Swift does it automatically.
    let appGroupStateStore = AppGroupStateStore()
    
    @State private var showingPicker = false
    @State private var appState = AppState.inactive
    @State private var restrictionEndsAt = false
    
    @State private var selection = FamilyActivitySelection()
    @State private var scrollLimit = 0
    @State private var lockoutPeriod = 0
    
    private func submitForm(){
        appGroupStateStore.setSelectedApps(selection)
        appGroupStateStore.setScrollLimit(scrollLimit)
        appGroupStateStore.setLockoutPeriod(lockoutPeriod)
        appGroupStateStore.setAppState(appState)
        appGroupStateStore.setRestrictionEndsAt(0)
        print("Form submitted")
        dismiss()
    }
    
    
    var body: some View {
        VStack{
            Text("Configure blocking page")
            
            Form{
                Section(header:Text("Select offending apps")){
                    Button("Choose Apps"){
                        showingPicker = true
                    }
                    .familyActivityPicker(isPresented: $showingPicker, selection: $selection)
                }
                
                Section(header: Text("Select scroll time (minutes)")){
                    TextField("Scroll limit (minutes)", value:$scrollLimit, format: .number)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Select lockout period duration (minutes)")){
                    TextField("LockoutPeriod (minutes)", value:$lockoutPeriod, format: .number)
                        .keyboardType(.numberPad)
                }
                
                Section{
                    Button("Save"){submitForm()}.buttonStyle(.borderedProminent)
                }
                
            }
        
            
        }
        
        
    }
    
}

#Preview {ConfigureBlockingView()}
