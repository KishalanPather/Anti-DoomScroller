//
//  ActionSectionView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/09/06.
//
import SwiftUI

struct ActionSectionView: View {
    
    struct ActionButton<S: PrimitiveButtonStyle>:View{
        let title: String
        let colour: Color
        let iconName: String
        let buttonStyle: S
        let action: () -> Void
        
        var body: some View{
            Button{
                action()
            } label: {
                Label(title, systemImage: iconName)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(buttonStyle)
            .tint(colour)
            .controlSize(.large)
        }
    }
    
    var body: some View{
        VStack(spacing: 16) {
            
            if AppGroupStateStore.shared.appState == .inactive || AppGroupStateStore.shared.appState == .monitoring {
                
                ActionButton(title: "Activate Monitoring",colour: .green, iconName: "shield.fill", buttonStyle: .borderedProminent){
                    MonitoringService.startMonitorScrollLimitWithIntervals()}
                
                ActionButton(title: "Stop Monitoring",colour: .red, iconName: "stop.circle.fill", buttonStyle: .bordered){
                    MonitoringService.stopMonitorScrollLimit()}
                
            } else{
                ActionButton(title: "Activate Monitoring",colour: .gray, iconName: "shield.fill", buttonStyle: .borderedProminent){
                    print("Cannot activate while already in a restricted state")}
                
                ActionButton(title:"Stop Monitoring" ,colour: .gray, iconName: "shield.circle.fill", buttonStyle: .bordered){
                    print("Cannot stop when in a restricted state")}
        
            }
            
        }
    }
}

#Preview {
    ActionSectionView()
}
