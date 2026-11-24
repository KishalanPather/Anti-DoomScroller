//
//  ActionSectionView.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/09/06.
//
import SwiftUI

struct ActionSectionView: View {
    
    let blockingService = BlockingService()
    
    
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
    
    func startBlockingNow(){
        blockingService.startBlocking(selection: AppGroupStateStore.shared.getSelectedApps()!)
        MonitoringService.startMonitorLockoutPeriod()
        AppGroupStateStore.shared.restrictionStartsAt = Date()
        AppGroupStateStore.shared.restrictionEndsAt = Calendar.current.date(byAdding: .minute, value: AppGroupStateStore.shared.lockoutPeriod, to: AppGroupStateStore.shared.restrictionStartsAt)!
    }
    
    
    var body: some View{
        VStack(spacing: 16) {
            
            if AppGroupStateStore.shared.appState == .inactive || AppGroupStateStore.shared.appState == .monitoring {
                
                ActionButton(title: "Activate Monitoring",colour: .green, iconName: "shield.fill", buttonStyle: .borderedProminent){
                    MonitoringService.startMonitorScrollLimitWithIntervals()}
                
                ActionButton(title: "Block Now",colour: .red, iconName: "stop.circle.fill", buttonStyle: .borderedProminent){
                    startBlockingNow()}
                
                ActionButton(title: "Stop Monitoring",colour: .red, iconName: "stop.circle.fill", buttonStyle: .bordered){
                    MonitoringService.stopMonitorScrollLimit()}
                
            } else{
                ActionButton(title: "Activate Monitoring",colour: .gray, iconName: "shield.fill", buttonStyle: .borderedProminent){
                    print("Cannot activate while already in a restricted state.")}
                
                ActionButton(title: "Block Now",colour: .gray, iconName: "stop.circle.fill", buttonStyle: .borderedProminent){
                    print("Cannot block now when in a restricted state.")}
                
                ActionButton(title:"Stop Monitoring" ,colour: .gray, iconName: "shield.circle.fill", buttonStyle: .bordered){
                    print("Cannot stop when in a restricted state.")}
                

            }
            
        }
    }
}

#Preview {
    ActionSectionView()
}
