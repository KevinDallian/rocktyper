//
//  HistoryManager.swift
//  TyperGame
//
//  Created by Kevin Dallian on 24/05/23.
//

import Foundation

class HistoryManager : Codable {
    private var histories : [History] = []
    private init(){
    }
    
    static var shared : HistoryManager = {
        if let data = UserDefaults.standard.data(forKey: "HistoryManager"){
            do {
                let decoder = JSONDecoder()
                let historyManager = try decoder.decode(HistoryManager.self, from: data)
                return historyManager
            } catch{
                print("error decoding history manager :\(error.localizedDescription)")
            }
        }
        return HistoryManager()
    }()
    
    func appendHistory(history: History){
        if histories.contains(where: { oldHistory in
            oldHistory.name == history.name
        }) {
            let index = histories.firstIndex { oldHistory in
                oldHistory.name == history.name
            }
            if history.totalRocks > histories[index!].totalRocks{
                histories.remove(at: index!)
                histories.append(history)
            }
        }else{
            histories.append(history)
        }
        decodeJSON()
    }
    
    func getHistories() -> [History]{
        let sortedHistories = histories.sorted {$0.wpm > $1.wpm}
        let topHistories = Array(sortedHistories.prefix(8))
        return topHistories
    }
    
    func decodeJSON(){
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(HistoryManager.shared)
            
            UserDefaults.standard.set(data, forKey: "HistoryManager")
        } catch {
            print("Error encoding myObject: \(error.localizedDescription)")
        }
    }
}
