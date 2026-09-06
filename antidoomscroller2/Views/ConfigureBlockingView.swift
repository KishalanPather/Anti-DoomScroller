//
//  ConfigureBlockingView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/20.
//

import SwiftUI
import FamilyControls

struct ConfigureBlockingView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showingPicker = false
    @State private var appState = AppState.inactive
    
    @State private var selection = FamilyActivitySelection()
    @State private var scrollLimit = 0
    @State private var lockoutPeriod = 0
    
    private func submitForm() {
        AppGroupStateStore.shared.selectedApps = selection
        AppGroupStateStore.shared.appState = appState
        AppGroupStateStore.shared.scrollLimit = scrollLimit
        AppGroupStateStore.shared.lockoutPeriod = lockoutPeriod
        print("Form submitted")
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button {
                        showingPicker = true
                    } label: {
                        Label("Choose Restricted Apps", systemImage: "apps.iphone")
                    }
                    .familyActivityPicker(isPresented: $showingPicker, selection: $selection)
                } header: {
                    Text("Target Apps")
                } footer: {
                    Text("Select the apps that should trigger the timer.")
                }
                
                Section {
                    HStack {
                        Text("ScrollLimit")
                        Spacer()
                        TextField("0", value: $scrollLimit, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 200)
                        Text("min")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Lockout Period")
                        Spacer()
                        TextField("0", value: $lockoutPeriod, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                        Text("min")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Time Settings")
                }
            }
            .navigationTitle("Configure Limits")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        submitForm()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {ConfigureBlockingView()}


