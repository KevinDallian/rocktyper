//
//  HomeScene.swift
//  TyperGame
//
//  Created by Kevin Dallian on 20/05/23.
//
import SpriteKit
import GameplayKit

class HomeScene: SKScene {
    private var playBtn : SKSpriteNode!
    private var statBtn : SKSpriteNode!
    private var howBtn : SKSpriteNode!
    var wordManager = WordManager.shared
    
    override func didMove(to view: SKView) {
        self.playBtn = self.childNode(withName: "//playBtn") as? SKSpriteNode
        self.statBtn = self.childNode(withName: "//statBtn") as? SKSpriteNode
        self.howBtn = self.childNode(withName: "//howBtn") as? SKSpriteNode
    }
    
    override func mouseUp(with event: NSEvent){
        let location = event.location(in: self)
        
        if atPoint(location) == playBtn {
            goToScene(scene: GameScene())
        }
        else if atPoint(location) == statBtn {
            goToScene(scene: SKScene(fileNamed: "StatScene")!)
        }
        else if atPoint(location) == howBtn{
            goToScene(scene: SKScene(fileNamed: "HowToPlayScene")!)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func goToScene(scene: SKScene){
        let sceneTransition = SKTransition.fade(with: SKColor.darkGray, duration: 1)
        scene.scaleMode = .resizeFill
        self.view?.presentScene(scene, transition: sceneTransition)
    }
}
