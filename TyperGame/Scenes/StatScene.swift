//
//  StatScene.swift
//  TyperGame
//
//  Created by Kevin Dallian on 24/05/23.
//

import Foundation
import SpriteKit

class StatScene : SKScene {
    private var backButton : SKSpriteNode!
    private var emptyLabel : SKLabelNode!
    private var nameLabel : SKLabelNode!
    private var wpmLabel : SKLabelNode!
    private var accuracyLabel : SKLabelNode!
    var histories = HistoryManager.shared.getHistories()
    
    override func didMove(to view : SKView){
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.emptyLabel = self.childNode(withName: "//emptyLabel") as? SKLabelNode
        self.nameLabel = self.childNode(withName: "//nameLabel") as? SKLabelNode
        self.wpmLabel = self.childNode(withName: "//wpmLabel") as? SKLabelNode
        self.accuracyLabel = self.childNode(withName: "//accuracyLabel") as? SKLabelNode
        
        if !histories.isEmpty {
            emptyLabel.isHidden = true
            getHistoryNode()
        } else {
            nameLabel.isHidden = true
            wpmLabel.isHidden = true
            accuracyLabel.isHidden = true
        }
    }
    
    override func mouseUp(with event: NSEvent){
        let location = event.location(in: self)
        
        if atPoint(location) == backButton {
            goToHomeScene()
        }
    }
    
    func goToHomeScene(){
        let homeScene = SKScene(fileNamed: "HomeScene")
        homeScene!.scaleMode = .aspectFill
        let reveal = SKTransition.fade(with: SKColor.gray, duration: 1)
        self.view?.presentScene(homeScene!, transition: reveal)
    }
    
    func getHistoryNode(){
        var row = 0
        for history in histories {
            let historyNode = HistoryNode(name: history.name, totalRocks: history.totalRocks, accuracy: history.accuracy)
            historyNode.nameNode.position = CGPoint(x: frame.midX - 160, y: frame.maxY - 300 - CGFloat(50 * row))
            historyNode.totalRockNode.position = CGPoint(x: frame.midX, y: frame.maxY - 300 - CGFloat(50 * row))
            historyNode.accuracyNode.position = CGPoint(x: frame.midX + 160, y: frame.maxY - 300 - CGFloat(50 * row))
            addChild(historyNode)
            row += 1
        }
    }
}
