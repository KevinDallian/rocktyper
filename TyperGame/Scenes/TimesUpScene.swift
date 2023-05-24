//
//  TimesUpScene.swift
//  TyperGame
//
//  Created by Kevin Dallian on 23/05/23.
//

import Foundation
import SpriteKit

class TimesUpScene : SKScene {
    var wordManager = WordManager.shared
    private var rockCounter : SKLabelNode!
    private var wpm : SKLabelNode!
    private var accuracy : SKLabelNode!
    private var textField : SKLabelNode?
    let congratsSound = SKAction.playSoundFileNamed("congratulations", waitForCompletion: false)
    
    override func didMove(to view: SKView){
        run(congratsSound)
        self.rockCounter = self.childNode(withName: "//rockCounter") as? SKLabelNode
        self.rockCounter.text = "You have crushed \(wordManager.rockCrushedCounter) rocks"
        
        self.wpm = self.childNode(withName: "//wpm") as? SKLabelNode
        self.wpm.text = String(format: "Rocks per Minute : %.0f", wordManager.calculateWPM())
        
        self.accuracy = self.childNode(withName: "//accuracy") as? SKLabelNode
        self.accuracy.text = String(format: "accuracy : %.0f", wordManager.calculateAccuracy())
        
        let roundedRectangle = SKShapeNode(rectOf: CGSize(width: 300, height: 50), cornerRadius: CGFloat(10))
        roundedRectangle.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        roundedRectangle.fillColor = .darkGray
        roundedRectangle.strokeColor = .darkGray
        addChild(roundedRectangle)
        
        self.textField = SKLabelNode(text: "")
        self.textField?.position = CGPoint(x: frame.midX, y: frame.midY - 210)
        addChild(textField!)
        
    }
    
    override func keyDown(with event: NSEvent) {
        guard let characters = event.characters else { return }
        let keyCode = event.keyCode

        for character in characters {
            let characterString = String(character)
            
            if keyCode == 36 { // enter
                wordManager.createHistory(name: textField!.text!)
                goToHomeScene()
                print(HistoryManager.shared.getHistories())
                wordManager.resetWordManager()
            } else if keyCode == 51 { // backspace
                textField!.text! = String(textField!.text!.dropLast())
            }
            else{ // any key pressed
                textField!.text! += characterString
                textField!.fontName = "Skia"
                textField?.fontColor = .white
                textField?.fontSize = 32
            }
        }
    }
    
    func goToHomeScene(){
        let homeScene = SKScene(fileNamed: "HomeScene")
        homeScene!.scaleMode = .aspectFill
        let reveal = SKTransition.fade(with: SKColor.gray, duration: 1)
        self.view?.presentScene(homeScene!, transition: reveal)
    }
}
