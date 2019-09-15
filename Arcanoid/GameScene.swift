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
    
    var menuCreator:MenuCreator!
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.menuCreator = MenuCreator.init(scene: self.scene!)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
