//
//  MainView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/22.
//

import SwiftUI

struct MainView: View {
    @State private var showingConfigureBlocking = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    StatusCardView()
                    SettingsCardView(showingConfigureBlocking: $showingConfigureBlocking)
                    ActionSectionView()
                    DebugSectionView()
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground)) // Standard iOS background color
            .navigationTitle("Anti-Doomscroller")
            .sheet(isPresented: $showingConfigureBlocking) {
                ConfigureBlockingView()
            }
        }
    }
    

    

}

#Preview {
    MainView()
}
