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
    
    var timeToUpdate:Double!
    var timeOfset:Double = 1
    
    struct NodeName {
        static var borderNode = "borderNode"
        static var playerNode = "playerNode"
        static var bollNode = "bollNode"
        static var cellNode = "cellNode"
    }
    
    init(scene: SKScene!) {
        self.scene = scene
        self.gameCreator = GameCreator.init(scene: scene)
    }
    
    
    func showGame() {

    }
    
    func update(currentTime:Double) {
        if timeToUpdate == nil {
            timeToUpdate = currentTime + timeOfset
        } else {
            movePlayer()
        }
    }
    
    
    //MARK: Touch handlers
    
    func touchesBeganHandler(touchesNodes:[SKNode], location: CGPoint) {
        if location.x < 0 {
            gameCreator.player.direction = 1
        } else if location.x > 0 {
            gameCreator.player.direction = 2
        }
    }
    
    func touchesEndedHandler(touchesNodes:[SKNode]) {
        if gameCreator.player.direction == 1 || gameCreator.player.direction == 2 {
            gameCreator.player.direction = 0
        }
    }
    
    //MARK: Movement methods
    
    //Decides to move or not to move player by player x position compared to border x position
    func movePlayer() {
        var isMove = true
        switch gameCreator.player.direction {
        case 1:
            //Left
            if gameCreator.player.node.position.x - 60 <= gameCreator.border.leftLine.p1.x {
                isMove = false
            }
            if isMove {
                gameCreator.player.node!.position.x -= 10
            }
        case 2:
            //Right
            if gameCreator.player.node.position.x + 60 >= gameCreator.border.rightLine.p1.x {
                isMove = false
            }
            if isMove {
                gameCreator.player.node!.position.x += 10
            }
        default:
            break;
        }
        
    }
    
    
    
}
