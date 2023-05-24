//
//  HistoryManager.swift
//  TyperGame
//
//  Created by Kevin Dallian on 24/05/23.
//

import Foundation

class HistoryManager {
    private var histories : [History] = []
    private init(){
        appendHistory(history: History(name: "Kevin", wpm: 100, accuracy: 100))
        appendHistory(history: History(name: "Gerald", wpm: 100, accuracy: 80))
        appendHistory(history: History(name: "RandomName", wpm: 200, accuracy: 80))
        appendHistory(history: History(name: "Typer", wpm: 150, accuracy: 80))
        appendHistory(history: History(name: "RandomName1", wpm: 100, accuracy: 100))
        appendHistory(history: History(name: "RandomTyper", wpm: 100, accuracy: 80))
        appendHistory(history: History(name: "Catherine", wpm: 200, accuracy: 80))
        appendHistory(history: History(name: "Random", wpm: 150, accuracy: 80))
        appendHistory(history: History(name: "Kevin", wpm: 100, accuracy: 100))
        appendHistory(history: History(name: "Meme", wpm: 100, accuracy: 80))
        appendHistory(history: History(name: "Mamam", wpm: 200, accuracy: 80))
        appendHistory(history: History(name: "Dewa", wpm: 150, accuracy: 80))
    }
    
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
