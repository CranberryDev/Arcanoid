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
    
    var scene: GameScene
    var gameCreator:GameCreator!
    var menuManager:MenuManager!
    
    var timeToUpdate:Double!
    var timeOfset:Double = 1
    
    var logicUpdateTime:Double!
    var frameTime:Double = 0.016
    
    struct NodeName {
        static var borderNode = "borderNode"
        static var playerNode = "playerNode"
        static var bollNode = "bollNode"
        static var cellNode = "cellNode"
    }
    
    init(scene: SKScene!, menu: MenuManager) {
        self.scene = scene.scene as! GameScene
        self.menuManager = menu
        self.gameCreator = GameCreator.init(scene: scene)
    }
    
    func update(currentTime:Double) {
        if timeToUpdate == nil {
            timeToUpdate = currentTime + timeOfset
        } else {
            let now = Date().timeIntervalSince1970
            if scene.gameState == GameScene.States.game {
                movePlayer(now)
                moveBoll(now)
                logicUpdateTime = Date().timeIntervalSince1970
            } else if scene.gameState == GameScene.States.endGame {
                transferToEndGameScene()
            }
            
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
    
    func movePlayer(_ currentTime:Double) {
        var isMove = true
        switch gameCreator.player.direction {
        case 1:
            //Left
            if gameCreator.player.node.position.x - 60 <= gameCreator.border.leftLine.p1.x {
                isMove = false
            }
            if isMove {
                let corrector = getCorrector(currentTime)
                gameCreator.player.node!.position.x = gameCreator.player.node!.position.x - CGFloat(10*corrector)
            }
        case 2:
            //Right
            if gameCreator.player.node.position.x + 60 >= gameCreator.border.rightLine.p1.x {
                isMove = false
            }
            if isMove {
                let corrector = getCorrector(currentTime)
                gameCreator.player.node!.position.x = gameCreator.player.node!.position.x + CGFloat(10*corrector)
            }
        default:
            break;
        }
    }
    
    func moveBoll(_ currentTime:Double) {
        var shouldMove = true
        let bollLocation:CGPoint = gameCreator.boll.boll!.position
        
        let bollOfset:CGFloat = 20
        
        if bollLocation.x + bollOfset >= gameCreator.border.rightLine.p1.x {
            //Right border collision
            gameCreator.boll.direction.x = -1
        } else if bollLocation.x - bollOfset <= gameCreator.border.leftLine.p1.x {
            //Left border collision
            gameCreator.boll.direction.x = 1
        } else if bollLocation.y + bollOfset >= gameCreator.border.topLine.p1.y {
            //Top border collision
            gameCreator.boll.direction.y = -1
        } else if bollLocation.y <= gameCreator.border.leftLine.p1.y {
            shouldMove = false
            scene.gameState = GameScene.States.endGame
            //End game
        } else {
            //Collision with cell or with player
            let contactedNodesBottom:[SKNode] = scene.nodes(at: CGPoint(x: bollLocation.x, y: bollLocation.y - bollOfset))
            let contactedNodesTop:[SKNode] = scene.nodes(at: CGPoint(x: bollLocation.x, y: bollLocation.y + bollOfset))
            let contactedNodesRight:[SKNode] = scene.nodes(at: CGPoint(x: bollLocation.x + bollOfset, y: bollLocation.y))
            let contactedNodesLeft:[SKNode] = scene.nodes(at: CGPoint(x: bollLocation.x - bollOfset, y: bollLocation.y))
            
            if contactedNodesBottom.count != 1 && gameCreator.boll.direction.y < 0 {
                //When boll go bottom then y coordinate should be negative
                for node in contactedNodesBottom {
                    if node.name == NodeName.playerNode && !(gameCreator.boll.direction.x == 1 && gameCreator.boll.direction.y == 1) {
                        //Change boll directino from left to right and from rigth to left
                        gameCreator.boll.direction.y = -(gameCreator.boll.direction.y)
                        break;
                    } else if node.name == NodeName.cellNode {
                        //Hide node cell and change direction
                        gameCreator.gameBorder.removeChildren(in: [node])
                        gameCreator.boll.direction.y = -(gameCreator.boll.direction.y)
                        gameCreator.score.counter += 1
                        gameCreator.score.label.text = "Your score: \(gameCreator.score.counter)"
                        break;
                    }
                }
            } else if contactedNodesTop.count != 1 && gameCreator.boll.direction.y > 0 {
                //When boll go up then y coordinate should be positive
                for node in contactedNodesTop {
                    if node.name == NodeName.cellNode {
                        gameCreator.gameBorder.removeChildren(in: [node])
                        gameCreator.boll.direction.y = -(gameCreator.boll.direction.y)
                        gameCreator.score.counter += 1
                        gameCreator.score.label.text = "Your score: \(gameCreator.score.counter)"
                        break;
                    }
                }
            } else if contactedNodesRight.count != 1 && gameCreator.boll.direction.x > 0 {
                //When boll go right then x coordinate should be positive
                for node in contactedNodesRight {
                    if node.name == NodeName.cellNode {
                        gameCreator.gameBorder.removeChildren(in: [node])
                        gameCreator.boll.direction.x = -(gameCreator.boll.direction.x)
                        gameCreator.score.counter += 1
                        gameCreator.score.label.text = "Your score: \(gameCreator.score.counter)"
                        break;
                    }
                }
            } else if contactedNodesLeft.count != 1 && gameCreator.boll.direction.x < 0 {
                //When boll go left then x coordinate should be negative
                for node in contactedNodesLeft {
                    if node.name == NodeName.cellNode {
                        gameCreator.gameBorder.removeChildren(in: [node])
                        gameCreator.boll.direction.x = -(gameCreator.boll.direction.x)
                        gameCreator.score.counter += 1
                        gameCreator.score.label.text = "Your score: \(gameCreator.score.counter)"
                        break;
                    }
                }
            }
        }
        
        if shouldMove {
            let corrector = getCorrector(currentTime)
            gameCreator.boll.boll!.position.x += CGFloat(7 * gameCreator.boll.direction!.x * Double(corrector))
            gameCreator.boll.boll!.position.y += CGFloat(7 * gameCreator.boll.direction!.y * Double(corrector))
        }
    }
    
    
    //MARK: Outer class integration
    
    func moveScoreForEndGameScene() {
        gameCreator.scoreLabelForEndGameScene()
    }
    
    func resetGame() {
        gameCreator.resetGame()
        logicUpdateTime = nil
    }
    
    
    //MARK: Private methods
    
    //MARK: Transfer
    
    private func transferToEndGameScene() {
        let duration = 0.3
        gameCreator.gameBorder.run(SKAction.fadeOut(withDuration: duration))
        gameCreator.boll.boll.run(SKAction.fadeOut(withDuration: duration))
        gameCreator.player.node!.run(SKAction.fadeOut(withDuration: duration))
        gameCreator.border.border!.run(SKAction.fadeOut(withDuration: duration)) {
            self.gameCreator.gameBorder.isHidden = true
            self.gameCreator.boll.boll.isHidden = true
            self.gameCreator.player.node!.isHidden = true
            self.gameCreator.border.border!.isHidden = true
        }
        menuManager.toEndGameMenu()
    }
    
    
    private func getCorrector(_ now:Double) -> CGFloat {
        var corrector:CGFloat = 1
        if logicUpdateTime != nil {
            corrector = CGFloat((now-logicUpdateTime)/frameTime)
            corrector = CGFloat(Float(String(format: "%.2f", corrector))!)
            if corrector <= 0 {
                corrector = 1
            }
        }
        return corrector
    }
    
    
    
}
