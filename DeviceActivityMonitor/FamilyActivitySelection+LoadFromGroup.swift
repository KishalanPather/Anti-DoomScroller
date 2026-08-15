//
//  FamilyActivitySelection+LoadFromGroup.swift
//  antidoomscroller2
//
//  Created by Kishalan Pather on 2026/08/15.
//

import FamilyControls
import Foundation

let appGroupID = "group.com.kishalan.antidoomscroller2"
let key = "savedAppSelection"

extension FamilyActivitySelection{
    
    static func loadFromAppGroup() -> FamilyActivitySelection? {
        let sharedDefaults = UserDefaults(suiteName: appGroupID)
        
        if let savedData = sharedDefaults?.data(forKey: key){
            let decoder = JSONDecoder()
            let decodedSelection = try? decoder.decode(FamilyActivitySelection.self, from: savedData)
            print("Successfully decoded selection.")
            return decodedSelection
        }
        print("Unable to decode selection")
        return nil
    }
}
