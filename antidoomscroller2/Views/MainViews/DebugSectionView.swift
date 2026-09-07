//
//  DebugSectionView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/09/07.
//
import SwiftUI

struct DebugSectionView: View{
    
    @State private var scrollLimitDebugAG: String = ""
    @State private var lockoutPeriodDebugAG: String = ""
    @State private var StartsDebugAG: String = ""
    @State private var EndsDebugAG: String = ""
    
    @State private var scrollLimitDebugShared: String = ""
    @State private var lockoutPeriodDebugShared: String = ""
    @State private var StartsDebugShared: String = ""
    @State private var EndsDebugShared: String = ""
    
    var body: some View{
            VStack {
                Divider()
                    .padding(.vertical)
                
                Text(scrollLimitDebugAG)
                Text(lockoutPeriodDebugAG)
                Text(StartsDebugAG)
                Text(EndsDebugAG)
                
                
                Text(scrollLimitDebugShared)
                Text(lockoutPeriodDebugShared)
                Text(StartsDebugShared)
                Text(EndsDebugShared)
                
                Button("Print AppGroup State (Debug)") {
                    let defaults = AppGroupStateStore.shared.defaults
                    scrollLimitDebugAG = "(AG) Scroll Limit: \(defaults.integer(forKey: "scrollLimit"))"
                    lockoutPeriodDebugAG = "(AG) Lockout Period: \(defaults.integer(forKey: "lockoutPeriod"))"
                    StartsDebugAG = "(AG) Starts: \(String(describing: defaults.object(forKey: "restrictionStartsAt")))"
                    EndsDebugAG = "(AG) Ends: \(String(describing: defaults.object(forKey: "restrictionEndsAt")))"
                    
                    scrollLimitDebugShared = "(AppGroupStateStore) Scroll Limit: \(AppGroupStateStore.shared.scrollLimit))"
                    lockoutPeriodDebugShared = "(AppGroupStateStore) Lockout Period: \(AppGroupStateStore.shared.lockoutPeriod))"
                    StartsDebugShared = "(AppGroupStateStore) Starts: \(AppGroupStateStore.shared.restrictionStartsAt))"
                    EndsDebugShared = "(AppGroupStateStore) Ends: \(AppGroupStateStore.shared.restrictionEndsAt))"
                    
                    
                    
                    
                    print("Scroll Limit: \(defaults.integer(forKey: "scrollLimit"))")
                    print("Lockout Period: \(defaults.integer(forKey: "lockoutPeriod"))")
                    print("Starts: \(String(describing: defaults.object(forKey: "restrictionStartsAt")))")
                    print("Ends: \(String(describing: defaults.object(forKey: "restrictionEndsAt")))")
                    
                }
                .font(.footnote)
                .foregroundColor(.gray)
                
            }
        
    }
}

#Preview {
    DebugSectionView()
}
