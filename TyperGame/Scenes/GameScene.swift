//
//  GameScene.swift
//  TyperGame
//
//  Created by Kevin Dallian on 20/05/23.
//

import Foundation
import SpriteKit

class GameScene : SKScene{
    override func didMove(to view: SKView){
        super.didMove(to: view)
        let background = SKSpriteNode(imageNamed: "background2")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 0
        background.size = self.size
        addChild(background)
        
        for x in 0 ..< 4 {
            let rock = RockNode(text: "miner")
            rock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            rock.position = CGPoint(x: 0.2 + rock.size.height * CGFloat(x), y: 0.5)
            addChild(rock)
        }
        
    }
}
