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
    override func didMove(to view: SKView){
        super.didMove(to: view)
        let background = SKSpriteNode(imageNamed: "background2")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)
        
        for x in 0 ..< 4 {
            let rock = RockNode(text: "miner")
            rock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            rock.position = CGPoint(x: frame.midX + rock.size.width * CGFloat(x), y: frame.midY)
            rocks.append(rock)
            addChild(rock)
        }
    }
    
    override func mouseUp(with event: NSEvent){
        let location = event.location(in: self)
        let convertedLocation = convert(location, to: self)
        
        if rocks[0].contains(convertedLocation){
            rocks[0].removeFromParent()
            rocks.removeFirst()
        }
        
    }
}
