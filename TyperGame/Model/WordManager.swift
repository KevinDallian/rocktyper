//
//  WordManager.swift
//  TyperGame
//
//  Created by Kevin Dallian on 22/05/23.
//

import Foundation

class WordManager {
    var words : [String] = []
    var rockCrushedCounter = 0
    var rockSkippedCounter = 0
    var characterErrors = 0
    var historyManager = HistoryManager.shared
    
    static var shared = WordManager()
    
    private init() {
        print("loading words")
        loadWords()
    }
    
    func calculateWPM() -> Double {
        let netTotalCharacters = (rockCrushedCounter * 5) + rockCrushedCounter - characterErrors
        
        return Double(netTotalCharacters) / (5 * 30) * 60
    }
    
    func calculateAccuracy() -> Double {
       Double(rockCrushedCounter) / Double(rockCrushedCounter + rockSkippedCounter) * 100
    }
    
    func loadWords() {
//        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=200&length=5") else {
//            return
//        }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            DispatchQueue.main.async{
//                if let data = data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let decodedWords = try decoder.decode([String].self, from: data)
//
//                        for decodedWord in decodedWords{
//                            self.words.append(decodedWord)
//                        }
//                        print(decodedWords)
//                    } catch {
//                        print("Error decoding JSON: \(error)")
//                    }
//                }
//            }
//        }.resume()
        
        self.words.append("bread")
        self.words.append("index")
        self.words.append("colon")
        self.words.append("swing")
        self.words.append("total")
        self.words.append("fight")
        self.words.append("paint")
        self.words.append("smoke")
        self.words.append("rifle")
        self.words.append("block")
        self.words.append("tight")
        self.words.append("score")
        self.words.append("elbow")
        self.words.append("glide")
        self.words.append("guest")
        self.words.append("other")
        self.words.append("width")
        self.words.append("pilot")
        self.words.append("robot")
        self.words.append("draft")
        self.words.append("entry")
        self.words.append("woman")
        self.words.append("shape")
        self.words.append("money")
        self.words.append("level")
        self.words.append("force")
        self.words.append("tread")
        self.words.append("thick")
        self.words.append("touch")
        self.words.append("trunk")
        self.words.append("grain")
        self.words.append("teach")
        self.words.append("learn")
        self.words.append("rally")
        self.words.append("issue")
        self.words.append("heart")
        self.words.append("crime")
        self.words.append("voice")
        self.words.append("drift")
        self.words.append("essay")
        self.words.append("float")
        self.words.append("climb")
        self.words.append("scene")
        self.words.append("bland")
        self.words.append("pitch")
        self.words.append("funny")
        self.words.append("count")
        self.words.append("miner")
        self.words.append("youth")
        self.words.append("ghost")
        self.words.append("grand")
        self.words.append("water")
        self.words.append("apple")
        self.words.append("quote")
        self.words.append("forge")
        self.words.append("muggy")
        self.words.append("steak")
        self.words.append("noble")
        self.words.append("charm")
        self.words.append("rumor")
        self.words.append("month")
        self.words.append("drift")
        self.words.append("glove")
        self.words.append("match")
        self.words.append("spoil")
        self.words.append("pause")
        self.words.append("truth")
        self.words.append("right")
        self.words.append("shake")
        self.words.append("prize")
        self.words.append("favor")
        self.words.append("nerve")
        self.words.append("angel")
        self.words.append("angle")
        self.words.append("world")
        self.words.append("minor")
        self.words.append("tooth")
        self.words.append("large")
        self.words.append("brand")
        self.words.append("first")
        self.words.append("stuff")
        self.words.append("salon")
        self.words.append("onion")
        self.words.append("feast")
        self.words.append("split")
        self.words.append("wagon")
        self.words.append("theft")
        self.words.append("obese")
        self.words.append("still")
        self.words.append("crime")
        self.words.append("raise")
        self.words.append("aloof")
        self.words.append("bowel")
        self.words.append("strap")
        self.words.append("weigh")
        self.words.append("drill")
        self.words.append("agony")
        self.words.append("learn")
        self.words.append("field")
        self.words.append("uncle")
        print(words)
    }
    
    func resetWordManager(){
        rockCrushedCounter = 0
        rockSkippedCounter = 0
    }
    
    func createHistory(name : String){
        let history = History(name: name, totalRocks : rockCrushedCounter, wpm: calculateWPM(), accuracy: calculateAccuracy())
        historyManager.appendHistory(history: history)
    }
}
