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
    var wordManager = WordManager.shared
    
    enum SceneName {
        case gameScene
        case statScene
    }
    
    override func didMove(to view: SKView) {
        self.playBtn = self.childNode(withName: "//playBtn") as? SKSpriteNode
        self.statBtn = self.childNode(withName: "//statBtn") as? SKSpriteNode
    }
    
    override func mouseUp(with event: NSEvent){
        let location = event.location(in: self)
        
        if atPoint(location) == playBtn {
            goToScene(scene: GameScene(), sceneName: .gameScene)
        }
        else if atPoint(location) == statBtn {
            goToScene(scene: SKScene(fileNamed: "StatScene")!, sceneName: .statScene)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func goToScene(scene: SKScene, sceneName : SceneName){
        let sceneTransition = SKTransition.fade(with: SKColor.gray, duration: 1)
        if sceneName == .statScene {
            scene.scaleMode = .fill
        }else{
            scene.scaleMode = .resizeFill
        }
        
        self.view?.presentScene(scene, transition: sceneTransition)
    }
}
