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
    
    override func didMove(to view: SKView){
        self.rockCounter = self.childNode(withName: "//rockCounter") as? SKLabelNode
        self.rockCounter.text = "You have crushed \(wordManager.rockCrushedCounter) rocks"
        
        self.wpm = self.childNode(withName: "//wpm") as? SKLabelNode
        self.wpm.text = "wpm : \(wordManager.calculateWPM())"
        
        self.accuracy = self.childNode(withName: "//accuracy") as? SKLabelNode
        self.accuracy.text = "accuracy : \(wordManager.calculateAccuracy())"
        
        let wait = SKAction.wait(forDuration: 3.0)
        let block = SKAction.run{
            let homeScene = SKScene(fileNamed: "HomeScene")
            homeScene!.scaleMode = .fill
            let reveal = SKTransition.fade(with: SKColor.gray, duration: 1)
            self.view?.presentScene(homeScene!, transition: reveal)
        }
        self.run(SKAction.sequence([wait, block]))
        wordManager.resetWordManager()
    }
}
