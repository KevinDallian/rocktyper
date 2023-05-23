//
//  RockNode.swift
//  TyperGame
//
//  Created by Kevin Dallian on 20/05/23.
//

import Foundation
import SpriteKit

class RockNode : SKSpriteNode{
    let textNode : SKLabelNode
    let rocks = ["rock1", "rock2", "rock3", "rock4"]
    
    init(text: String){
        let rockTexture = SKTexture(imageNamed: rocks.randomElement()!)
        let rockSize = rockTexture.size()
        let rockNode = SKSpriteNode(texture: rockTexture, color : .clear, size: rockSize)
        
        rockNode.size = CGSize(width: 120, height: 100)
        
        textNode = SKLabelNode(fontNamed: "SF Compact")
        textNode.text = text
        textNode.fontSize = 24
        textNode.fontColor = .black
        textNode.zPosition = 1
        
        super.init(texture: nil, color: .clear, size: rockNode.size)
        addChild(rockNode)
        addChild(textNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
