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
    var textField : SKLabelNode?
    override func didMove(to view: SKView){
        super.didMove(to: view)
        let background = SKSpriteNode(imageNamed: "background2")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)
        
        for x in 0 ..< 10 {
            let rock = RockNode(text: "miner")
            rock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            rock.position = CGPoint(x: rock.size.height + rock.size.width * CGFloat(x), y: frame.midY)
            rocks.append(rock)
            addChild(rock)
        }
        textField = SKLabelNode(text: "")
        textField?.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        addChild(textField!)
    }
    
    override func mouseUp(with event: NSEvent){
        let location = event.location(in: self)
        let convertedLocation = convert(location, to: self)
        
    }
    
    override func keyDown(with event: NSEvent) {
        guard let characters = event.charactersIgnoringModifiers else { return }

        for character in characters {
            let characterString = String(character)
            print(characterString)
            if characterString == " " {
                if checkWordIsTrue(word: textField!.text!){
                    rocks[0].removeFromParent()
                    rocks.removeFirst()
                }
                textField!.text! = ""
            }
            else{
                textField!.text! += characterString
            }
            
            
        }
    }
    
    func checkWordIsTrue(word: String) -> Bool{
        word == rocks.first?.textNode.text
    }
}
