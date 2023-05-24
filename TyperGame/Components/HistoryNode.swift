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
    let wpmNode : SKLabelNode!
    let accuracyNode : SKLabelNode!
    
    init(name: String, wpm: Double, accuracy: Double) {
        self.nameNode = SKLabelNode(text: name)
        self.nameNode.fontSize = 24
        self.nameNode.fontName = "Skia"
        self.nameNode.fontColor = .white
        
        self.wpmNode = SKLabelNode(text: String(format: "%.0f", wpm))
        self.wpmNode.fontSize = 24
        self.wpmNode.fontName = "Skia"
        self.wpmNode.fontColor = .white
        
        self.accuracyNode = SKLabelNode(text: String(format: "%.0f %%", accuracy))
        self.accuracyNode.fontSize = 24
        self.accuracyNode.fontName = "Skia"
        self.accuracyNode.fontColor = .white
        
        super.init(texture: nil, color: .clear, size: CGSize())
        addChild(nameNode)
        addChild(wpmNode)
        addChild(accuracyNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
