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
    

    var menuManager:MenuManager!
    var gameManager:GameManager!
    var gameState:States = States.game //0 - menu, 1 - game, 2 - pause, 3 - end game
    
    enum States:Int {
        case menu = 0
        case game = 1
        case pause = 2
        case endGame = 3
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        self.menuManager = MenuManager.init(scene: self.scene)
        self.gameManager = GameManager.init(scene: self.scene, menu: self.menuManager)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        gameManager.update(currentTime: currentTime)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            switch gameState {
            case States.menu:
                menuManager.touchEndedHandler(touchedNodes: touchedNodes)
            case States.game:
                gameManager.touchesEndedHandler(touchesNodes: touchedNodes);
            case States.pause:
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
            case States.menu:
                menuManager.touchBeganHandler(touchedNodes: touchedNodes)
            case States.game:
                gameManager.touchesBeganHandler(touchesNodes: touchedNodes, location: location);
            case States.pause:
                os_log(.debug, "Pause game", "")
            default:
                break
            }
        }
    }
}
