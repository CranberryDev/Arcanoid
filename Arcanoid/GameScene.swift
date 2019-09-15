//
//  GameScene.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import SpriteKit
import GameplayKit
import os.log


class GameScene: SKScene {
    
//    public var menuCreator:MenuCreator!
    var menuManager:MenuManager!
    var gameManager:GameManager!
    var gameState:Int = 1 //0 - menu, 1 - game, 2 - pause
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

//        self.menuManager = MenuManager.init(scene: self.scene)
        self.gameManager = GameManager.init(scene: self.scene)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        gameManager.update(currentTime: currentTime)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            switch gameState {
            case 0:
                menuManager.touchEndedHandler(touchedNodes: touchedNodes)
            case 1:
                gameManager.touchesEndedHandler(touchesNodes: touchedNodes);
            case 2:
                os_log(.debug, "Pause game", "")
            default:
                break
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            switch gameState {
            case 0:
                menuManager.touchBeganHandler(touchedNodes: touchedNodes)
            case 1:
                gameManager.touchesBeganHandler(touchesNodes: touchedNodes, location: location);
            case 2:
                os_log(.debug, "Pause game", "")
            default:
                break
            }
        }
    }
}
