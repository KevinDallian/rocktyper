//
//  GameScene.swift
//  TyperGame
//
//  Created by Kevin Dallian on 20/05/23.
//

import Foundation
import SpriteKit

class GameScene : SKScene{
    var rocks : [RockNode] = []
    var textField : SKLabelNode?
    var words : [String] = ["hello", "world", "this", "is", "fine", "mamam"]
    
    override func didMove(to view: SKView){
        loadWords()
        DispatchQueue.main.async{
            super.didMove(to: view)
            self.initializeBackground()
        }
        print(words)
    }
    
    func initializeBackground(){
        let background = SKSpriteNode(imageNamed: "background2")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)
        var index = 0
        for word in words {
            let rock = RockNode(text: word)
            rock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            rock.position = CGPoint(x: rock.size.height + rock.size.width * CGFloat(index), y: frame.midY)
            rocks.append(rock)
            addChild(rock)
            index += 1
        }
        textField = SKLabelNode(text: "")
        textField?.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        addChild(textField!)
    }
    
    override func mouseUp(with event: NSEvent){
        let location = event.location(in: self)
        let convertedLocation = convert(location, to: self)
    }
    
    override func keyDown(with event: NSEvent) {
        guard let characters = event.charactersIgnoringModifiers else { return }

        for character in characters {
            let characterString = String(character)
            print(characterString)
            if characterString == " " {
                if checkWordIsTrue(word: textField!.text!){
                    rocks[0].removeFromParent()
                    rocks.removeFirst()
                }
                textField!.text! = ""
            }
            else{
                textField!.text! += characterString
                textField!.fontName = "Arial"
                textField?.fontColor = .black
                textField?.fontSize = 32
            }
        }
    }
    
    func checkWordIsTrue(word: String) -> Bool{
        word == rocks.first?.textNode.text
    }
    
    func loadWords() {
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=50&length=5") else {
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
