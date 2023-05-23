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
    var currentTopRow = 0
    var timerIsOn = false
    let timerNode = TimerNode()
    var rockCounterLabel = SKLabelNode()
    var rockCounter = 0
    
    override func didMove(to view: SKView){
        super.didMove(to: view)
        self.initializeBackground()
        timerNode.timerIdle()
    }
    
    override func mouseUp(with event: NSEvent){
        let location = event.location(in: self)
        let convertedLocation = convert(location, to: self)
    }
    
    override func keyDown(with event: NSEvent) {
        if !timerIsOn {
            timerNode.startTimer()
            timerIsOn = true
        }
        guard let characters = event.characters else { return }
        let keyCode = event.keyCode

        for character in characters {
            let characterString = String(character)
            if characterString == " " {
                if checkWordIsTrue(word: textField!.text!, index: currentRockIndex){
                    nextRock()
                    if currentRockIndex != 7 && currentRockIndex % 7 == 0 {
                        generateRocks(row: 4)
                    }
                }
                textField!.text! = ""
            } else if keyCode == 51 {
                textField!.text! = String(textField!.text!.dropLast())
            }
            else{
                textField!.text! += characterString
                textField!.fontName = "Skia"
                textField?.fontColor = .black
                textField?.fontSize = 32
            }
        }
    }
    
    override func update(_ currentTime : TimeInterval){
        timerNode.updateTimer()
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
                rock.position = CGPoint(x: rock.size.height + rock.size.width * CGFloat(column), y: frame.maxY - 50 - CGFloat(row) * rock.size.height - rock.size.height)
                rocks.append(rock)
                addChild(rock)
                totalRocks += 1
            }
        }
        
        // textfield
        let textFieldBackground = SKSpriteNode(imageNamed: "textfieldBackground")
        textFieldBackground.position = CGPoint(x: frame.midX, y: frame.midY - 190)
        textFieldBackground.size = CGSize(width: 250, height: 80)
        addChild(textFieldBackground)
        textField = SKLabelNode(text: "")
        textField?.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        addChild(textField!)
        
        // timer
        let timerBackground = SKSpriteNode(imageNamed: "textfieldBackground")
        timerBackground.position = CGPoint(x: frame.minX + 100, y: frame.maxY - 50)
        timerBackground.size = CGSize(width: 100, height: 50)
        addChild(timerBackground)
        timerNode.fontName = "Skia"
        timerNode.fontSize = 32
        timerNode.fontColor = .black
        timerNode.position  = CGPoint(x: frame.minX + 100, y: frame.maxY - 57)
        timerNode.zPosition = 2
        addChild(timerNode)
        
        // rock counter
        let counterBackground = SKSpriteNode(imageNamed: "textfieldBackground")
        counterBackground.position = CGPoint(x: frame.maxX - 150, y: frame.maxY - 50)
        counterBackground.size = CGSize(width: 200, height: 55)
        addChild(counterBackground)
        let rockCounterImage = SKSpriteNode(imageNamed: "rock1")
        rockCounterImage.position = CGPoint(x: frame.maxX - 210, y: frame.maxY - 50)
        rockCounterImage.size = CGSize(width: 35, height: 35)
        addChild(rockCounterImage)
        rockCounterLabel.text = ":    \(rockCounter)"
        rockCounterLabel.fontName = "Skia"
        rockCounterLabel.fontSize = 32
        rockCounterLabel.fontColor = .black
        rockCounterLabel.position  = CGPoint(x: frame.maxX - 180, y: frame.maxY - 60)
        rockCounterLabel.horizontalAlignmentMode = .left
        addChild(rockCounterLabel)
        
    }
    
    func nextRock() {
        rocks[currentRockIndex].textNode.fontColor = NSColor(calibratedRed: 63/255, green: 232/255, blue: 20/255, alpha: 1.0)
        currentRockIndex += 1
        rockCounter += 1
        rockCounterLabel.text = ":    \(rockCounter)"
    }
    
    func generateRocks(row: Int){
        for column in 0..<7 {
            let rock = RockNode(text: wordManager.words[totalRocks])
            rock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            rock.position = CGPoint(x: rock.size.height + rock.size.width * CGFloat(column), y: frame.maxY - 50 - CGFloat(row) * rock.size.height)
            rock.setScale(0)
            rocks.append(rock)
            addChild(rock)
            totalRocks += 1
            let scaleAction = SKAction.scale(to: 1.0, duration: 0.2)
            let moveRocksAction = SKAction.run(moveRocksToTop)
            let removeTopRocksAction = SKAction.run(removeTopRocks)
            let sequenceAction = SKAction.sequence([scaleAction, moveRocksAction, removeTopRocksAction])
            rock.run(sequenceAction)
        }
        let delay = SKAction.wait(forDuration: 0.5)
        self.run(delay){
            self.currentTopRow += 1
        }
        
    }
    
    func moveRocksToTop() {
        var row = 0
        var index = 0
        for rockNode in rocks {
            let moveAction = SKAction.move(to: CGPoint(x: rockNode.position.x, y: rockNode.position.y + 100), duration: 0.2)
            rockNode.run(moveAction)
            index += 1
            if index % 7 == 0{
                row += 1
            }
        }
    }
    
    func removeTopRocks(){
        let dissapear = SKAction.scale(to: 0, duration: 0.2)
        let rotate = SKAction.rotate(toAngle: -2*Double.pi, duration: 0.2)
        let dissapearAndRotate = SKAction.group([dissapear, rotate])
        let topRow = (currentTopRow) * 7
        for index in 0..<7 {
            rocks[index + topRow].run(SKAction.sequence([dissapearAndRotate, SKAction.removeFromParent()]))
        }
    }
    
    func checkWordIsTrue(word: String, index : Int) -> Bool{
        word == wordManager.words[index]
    }
}
