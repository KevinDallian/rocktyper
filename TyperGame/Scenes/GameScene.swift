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
    var wordManager = WordManager.shared
    var totalRocks = 0
    var currentRockIndex = 0
    
    override func didMove(to view: SKView){
        super.didMove(to: view)
        self.initializeBackground()
    }
    
    func initializeBackground(){
        let background = SKSpriteNode(imageNamed: "background2")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)
        
        for row in 0..<3 {
            for column in 0..<7 {
                let rock = RockNode(text: wordManager.words[totalRocks])
                rock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                rock.position = CGPoint(x: rock.size.height + rock.size.width * CGFloat(column), y: frame.maxY - 20 - CGFloat(row) * rock.size.height - rock.size.height)
                rocks.append(rock)
                addChild(rock)
                totalRocks += 1
            }
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
        guard let characters = event.characters else { return }
        let keyCode = event.keyCode

        for character in characters {
            let characterString = String(character)
            if characterString == " " {
                if checkWordIsTrue(word: textField!.text!, index: currentRockIndex){
                    nextRock()
                }
                textField!.text! = ""
            } else if keyCode == 51 {
                textField!.text! = String(textField!.text!.dropLast())
            }
            else{
                textField!.text! += characterString
                textField!.fontName = "Arial"
                textField?.fontColor = .black
                textField?.fontSize = 32
            }
        }
    }
    
    func nextRock() {
        rocks[currentRockIndex].textNode.fontColor = .green
        currentRockIndex += 1
    }
    
//    func moveRocksToLeft() {
//        let initialXPosition: CGFloat = 100
//        let rockSpacing: CGFloat = 10
//        var index = 0
//        for rock in rocks {
//            let newXPosition = initialXPosition + CGFloat(index) * (rock.size.width + rockSpacing)
//            let moveAction = SKAction.moveTo(x: newXPosition, duration: 0.2)
//            rock.run(moveAction)
//            index += 1
//        }
//    }
    
    func checkWordIsTrue(word: String, index : Int) -> Bool{
        word == wordManager.words[index]
    }
    
}
