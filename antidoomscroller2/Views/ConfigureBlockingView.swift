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
    
    @State private var showingPicker = false
    @State private var appState = AppState.inactive
    @State private var restrictionEndsAt = 0
    
    @State private var selection = FamilyActivitySelection()
    @State private var scrollLimit = 0
    @State private var lockoutPeriod = 0
    
    
    private func submitForm(){
        AppGroupStateStore.shared.selectedApps = selection
        AppGroupStateStore.shared.appState = appState
        AppGroupStateStore.shared.scrollLimit = scrollLimit
        AppGroupStateStore.shared.lockoutPeriod = lockoutPeriod
        AppGroupStateStore.shared.restrictionEndsAt = restrictionEndsAt
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

//#Preview {ConfigureBlockingView()}
