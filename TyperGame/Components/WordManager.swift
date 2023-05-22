//
//  WordManager.swift
//  TyperGame
//
//  Created by Kevin Dallian on 22/05/23.
//

import Foundation

class WordManager {
    var words : [String] = ["hello", "world", "this", "is", "fine", "mamam"]
    
    static var shared = WordManager()
    
    private init() {
        print("loading words")
        loadWords()
    }
    
    func loadWords() {
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=200&length=5") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async{
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedWords = try decoder.decode([String].self, from: data)
                        
                        for decodedWord in decodedWords{
                            self.words.append(decodedWord)
                        }
                        print(decodedWords)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
        }.resume()
    }
}
