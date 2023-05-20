//
//  Button.swift
//  TyperGame
//
//  Created by Kevin Dallian on 20/05/23.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
    
    var action: (() -> Void)?
    
    override func mouseDown(with event: NSEvent) {
        action?()
    }
    
}
