//
//  FamilyControls+SaveToGroup.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/15.
//
import Foundation
import FamilyControls

let appGroupID = "group.com.kishalan.antidoomscroller2"
let key = "savedAppSelection"

extension FamilyActivitySelection{
    
    func saveToAppGroup(){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self){
            let sharedDefaults = UserDefaults(suiteName: appGroupID)
            sharedDefaults?.set(data,forKey: key)
            print("Successfully saved selection to App Group.")
        }
        print("Unable to save selection to App Group.")
    }
}
