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
    
    // Defaulting to the minimum values of your ranges
    @State private var scrollLimit: Int = 1
    @State private var lockoutPeriod: Int = 15
    
    // State to track which picker is currently expanded
    @State private var expandedPicker: ExpandedPicker? = nil
    
    enum ExpandedPicker {
        case scrollLimit, lockoutPeriod
    }
    
    private func submitForm() {
        AppGroupStateStore.shared.selectedApps = selection
        //AppGroupStateStore.shared.appState = appState
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
                    // MARK: - Scroll Limit Row
                    HStack {
                        Text("Scroll Limit")
                        Spacer()
                        Text("\(scrollLimit) min")
                            .foregroundColor(expandedPicker == .scrollLimit ? .blue : .secondary)
                    }
                    .contentShape(Rectangle()) // Makes the entire row tappable
                    .onTapGesture {
                        withAnimation {
                            expandedPicker = expandedPicker == .scrollLimit ? nil : .scrollLimit
                        }
                    }
                    
                    if expandedPicker == .scrollLimit {
                        Picker("Scroll Limit", selection: $scrollLimit) {
                            ForEach(1...60, id: \.self) { minute in
                                Text("\(minute) min").tag(minute)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    
                    // MARK: - Lockout Period Row
                    HStack {
                        Text("Lockout Period")
                        Spacer()
                        Text("\(lockoutPeriod) min")
                            .foregroundColor(expandedPicker == .lockoutPeriod ? .blue : .secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            expandedPicker = expandedPicker == .lockoutPeriod ? nil : .lockoutPeriod
                        }
                    }
                    
                    if expandedPicker == .lockoutPeriod {
                        Picker("Lockout Period", selection: $lockoutPeriod) {
                            ForEach(15...300, id: \.self) { minute in
                                Text("\(minute) min").tag(minute)
                            }
                        }
                        .pickerStyle(.wheel)
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

#Preview {
    ConfigureBlockingView()
}
