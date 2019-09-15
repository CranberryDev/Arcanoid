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
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
//        self.menuCreator = MenuCreator.init(scene: self.scene!)
        self.menuManager = MenuManager.init(scene: self.scene)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
//            menuManager.touchHandler(touchedNodes: touchedNodes)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            menuManager.touchHandler(touchedNodes: touchedNodes)
        }
    }
}
