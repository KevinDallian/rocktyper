//
//  HistoryNode.swift
//  TyperGame
//
//  Created by Kevin Dallian on 24/05/23.
//

import Foundation
import SpriteKit

class HistoryNode : SKSpriteNode {
    let nameNode : SKLabelNode!
    let totalRockNode : SKLabelNode!
    let accuracyNode : SKLabelNode!
    
    init(name: String, totalRocks: Int, accuracy: Double) {
        self.nameNode = SKLabelNode(text: name)
        self.nameNode.fontSize = 24
        self.nameNode.fontName = "Skia"
        self.nameNode.fontColor = .black
        
        self.totalRockNode = SKLabelNode(text: String(format: "%.0d", totalRocks))
        self.totalRockNode.fontSize = 24
        self.totalRockNode.fontName = "Skia"
        self.totalRockNode.fontColor = .black
        
        self.accuracyNode = SKLabelNode(text: String(format: "%.0f %%", accuracy))
        self.accuracyNode.fontSize = 24
        self.accuracyNode.fontName = "Skia"
        self.accuracyNode.fontColor = .black
        
        super.init(texture: nil, color: .clear, size: CGSize())
        addChild(nameNode)
        addChild(totalRockNode)
        addChild(accuracyNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
