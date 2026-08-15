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
            
            if let decodedSelection = try? decoder.decode(FamilyActivitySelection.self, from: savedData){
                return decodedSelection
            }
        }
        
        return nil
    }
}
