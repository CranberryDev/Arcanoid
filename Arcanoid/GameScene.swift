//
//  GameScene.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
//    public var menuCreator:MenuCreator!
    var menuManager:MenuManager!
    var gameManager:GameManager!
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        self.menuManager = MenuManager.init(scene: self.scene)
        self.gameManager = GameManager.init(scene: self.scene)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            menuManager.touchEndedHandler(touchedNodes: touchedNodes)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            menuManager.touchBeganHandler(touchedNodes: touchedNodes)
        }
    }
}
