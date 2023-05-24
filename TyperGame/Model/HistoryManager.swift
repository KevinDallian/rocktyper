//
//  HistoryManager.swift
//  TyperGame
//
//  Created by Kevin Dallian on 24/05/23.
//

import Foundation

class HistoryManager {
    private var histories : [History] = []
    private init(){}
    
    static var shared = HistoryManager()
    
    func appendHistory(history: History){
        histories.append(history)
    }
    
    func getHistories() -> [History]{
        let sortedHistories = histories.sorted {$0.wpm > $1.wpm}
        let topHistories = Array(sortedHistories.prefix(8))
        return topHistories
    }
}
