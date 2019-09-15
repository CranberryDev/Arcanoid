//
//  MenuManager.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import Foundation
import SpriteKit

class MenuManager {
    
    struct NodeName {
        //Main menu names
        static let playButton = "playButtonNode"
        static let choseButton = "choseLevelNode"
        static let gameTitle = "gameTitleNode"
        static let scoreLabel = "scoreLabelNode"
        
        //Level difficulty names
        static let easyButton = "easyButtonNode"
        static let mediumButton = "mediumButtonNode"
        static let hardButton = "hardButtonNode"
        static let backButton = "backButtonNode"
    }

    var menuCreator:MenuCreator!
    var scene:SKScene
    
    public init(scene: SKScene?) {
        self.scene = scene!
        self.menuCreator = MenuCreator.init(scene: scene!)
    }
    
    public func touchEndedHandler(touchedNodes: [SKNode?]) {
        for n in touchedNodes {
            guard let node = n else {
                continue
            }
            if node.name == NodeName.playButton {
                menuCreator.fromMainMenuToLevelDifficultyMenu()
            } else if node.name == NodeName.backButton {
                menuCreator.fromLevelDifficyltyMenuToMainMenu()
            }
        }
    }
    
    public func touchBeganHandler(touchedNodes: [SKNode?]) {
        for n in touchedNodes {
            guard let node = n else {
                continue
            }
            if node.name == NodeName.playButton {
                
            } else if node.name == NodeName.gameTitle {
                //Change font color, just for fun 🙂
                if menuCreator.gameTitle.fontColor == SKColor.red {
                    menuCreator.gameTitle.fontColor = SKColor.green
                } else if menuCreator.gameTitle.fontColor == SKColor.green {
                    menuCreator.gameTitle.fontColor = SKColor.yellow
                } else if menuCreator.gameTitle.fontColor == SKColor.yellow {
                    menuCreator.gameTitle.fontColor = SKColor.red
                }
            }
        }
    }
    
}
