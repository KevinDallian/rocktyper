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
    var restartBtn : SKSpriteNode!
    var rockCounterLabel = SKLabelNode()
    let correctSound : SKAction = SKAction.playSoundFileNamed("correct", waitForCompletion: false)
    let incorrectSound : SKAction = SKAction.playSoundFileNamed("incorrect", waitForCompletion: false)
    let wooshSound : SKAction = SKAction.playSoundFileNamed("wooshReduced", waitForCompletion: false)
    
    enum SceneName {
        case gameScene
        case congratulationScene
    }
    
    override func didMove(to view: SKView){
        super.didMove(to: view)
        self.initializeBackground()
        timerNode.timerIdle()
    }
    
    override func mouseUp(with event: NSEvent){
        let location = event.location(in: self)
        
        if atPoint(location) == restartBtn {
            restartGame()
        }
    }
    
    override func keyDown(with event: NSEvent) {
        if !timerIsOn {
            timerNode.startTimer()
            timerIsOn = true
            let startLabel = self.childNode(withName: "startLabel")
            startLabel?.removeFromParent()
        }
        guard let characters = event.characters else { return }
        let keyCode = event.keyCode

        for character in characters {
            let characterString = String(character)
            
            if characterString == " " { // space
                let wordIsTrue = checkWordIsTrue(word: textField!.text!, index: currentRockIndex)
                nextRock(wordIsTrue: wordIsTrue)
                if currentRockIndex != 7 && currentRockIndex % 7 == 0 {
                    generateRocks(row: 4)
                }
                textField!.text! = ""
            } else if keyCode == 51 { // backspace
                wordManager.characterErrors += 1
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
        if timerNode.timeIsUp {
            goToScene(scene: SKScene(fileNamed: "TimesUpScene")!, sceneName: .congratulationScene)
        }
    }
    
    func initializeBackground(){
        let background = SKSpriteNode(imageNamed: "background2")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)
        wordManager.words.shuffle()
        
        for row in 0..<3 {
            for column in 0..<7 {
                let rock = RockNode(text: wordManager.words[totalRocks])
                rock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                rock.position = CGPoint(x: frame.minX + rock.size.width + rock.size.width * CGFloat(column), y: frame.maxY - 50 - CGFloat(row) * rock.size.height - rock.size.height)
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
        counterBackground.position = CGPoint(x: frame.maxX - 160, y: frame.maxY - 50)
        counterBackground.size = CGSize(width: 150, height: 55)
        addChild(counterBackground)
        let rockCounterImage = SKSpriteNode(imageNamed: "rock1")
        rockCounterImage.position = CGPoint(x: frame.maxX - 200, y: frame.maxY - 50)
        rockCounterImage.size = CGSize(width: 35, height: 35)
        addChild(rockCounterImage)
        rockCounterLabel.text = "    \(wordManager.rockCrushedCounter)"
        rockCounterLabel.fontName = "Skia"
        rockCounterLabel.fontSize = 32
        rockCounterLabel.fontColor = .black
        rockCounterLabel.position  = CGPoint(x: frame.maxX - 140, y: frame.maxY - 60)
        rockCounterLabel.horizontalAlignmentMode = .left
        addChild(rockCounterLabel)
        
        // label for start
        let startLabel = SKLabelNode(text: "Press any key to start")
        startLabel.fontName = "Skia"
        startLabel.fontSize = 32
        startLabel.fontColor = .black
        startLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 60)
        startLabel.name = "startLabel"
        let bigScale = SKAction.scale(to: 1.02, duration: 0.5)
        let originalScale = SKAction.scale(to: 1.0, duration: 0.5)
        startLabel.run(SKAction.repeatForever(SKAction.sequence([bigScale, originalScale])))
        addChild(startLabel)
        
        restartBtn = SKSpriteNode(imageNamed: "restartButton")
        restartBtn.size = CGSize(width: 20, height: 20)
        restartBtn.position = CGPoint(x: 200, y: frame.maxY - 50)
        addChild(restartBtn)
    }
    
    func nextRock(wordIsTrue : Bool) {
        if wordIsTrue {
            rocks[currentRockIndex].textNode.fontColor = NSColor(calibratedRed: 0/255, green: 82/255, blue: 0/255, alpha: 1.0)
            wordManager.rockCrushedCounter += 1
            run(correctSound)
            
        }else{
            rocks[currentRockIndex].textNode.fontColor = NSColor(calibratedRed: 146/255, green: 2/255, blue: 5/255, alpha: 1.0)
            wordManager.rockSkippedCounter += 1
            run(incorrectSound)
        }
        
        currentRockIndex += 1
        rockCounterLabel.text = "    \(wordManager.rockCrushedCounter)"
    }
    
    func generateRocks(row: Int){
        for column in 0..<7 {
            let rock = RockNode(text: wordManager.words[totalRocks])
            rock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            rock.position = CGPoint(x: rock.size.height + rock.size.width * CGFloat(column) + 20, y: frame.maxY - 50 - CGFloat(row) * rock.size.height)
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
        run(wooshSound)
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
    
    func goToScene(scene : SKScene, sceneName : SceneName){
        var sceneTransition : SKTransition
        if sceneName == .gameScene {
            sceneTransition = SKTransition.fade(with: SKColor.gray, duration: 0.5)
            scene.scaleMode = .resizeFill
        }else{
            sceneTransition = SKTransition.flipHorizontal(withDuration: 0.5)
            scene.scaleMode = .aspectFill
        }
        self.view?.presentScene(scene, transition: sceneTransition)
    }
    
    func restartGame(){
        wordManager.resetWordManager()
        goToScene(scene: GameScene(), sceneName: .gameScene)
    }
}
