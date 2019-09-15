//
//  GameManager.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import Foundation
import SpriteKit

class GameManager {
    
    var scene: SKScene
    
    var gameCreator:GameCreator!
    
    init(scene: SKScene!) {
        self.scene = scene
        
        self.gameCreator = GameCreator.init(scene: scene)
    }
    
    
    func showGame() {
//        self.gameCreator.
    }
    
    
    
}
