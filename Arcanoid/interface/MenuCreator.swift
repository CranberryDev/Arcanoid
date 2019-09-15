//
//  MenuCreator.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import SpriteKit

class MenuCreator {
    
    var scene:SKScene
    
    var gameTitle:SKLabelNode = SKLabelNode()
    var bestScore:SKLabelNode = SKLabelNode()
    
    var playButton:ButtonComponents = ButtonComponents()
    var levelButton:ButtonComponents = ButtonComponents()
    
    
    struct ButtonComponents{
        var outerShape:SKShapeNode!
        var innerShape:SKShapeNode!
        var textLabel:SKLabelNode!
    }
    
    let fontName:String = "ArialRoundedMTBold"
    
    public init(scene: SKScene) {
        self.scene = scene
        
        initMainMenu()
    }
    
    func showMenu() {
        playButton.innerShape.isHidden = false
        playButton.outerShape.isHidden = false
        playButton.textLabel.isHidden = false
    }
    
    //MARK: Private methods
    
    private func initMainMenu() {
        scene.backgroundColor = SKColor.lightGray
        
        //Init game title
        gameTitle.zPosition = 1
        gameTitle.position = CGPoint(x: 0, y: scene.size.height / 3)
        gameTitle.text = "ARCANOID"
        gameTitle.fontColor = SKColor.red
        gameTitle.fontName = fontName
        gameTitle.fontSize = 60
        gameTitle.name = "gameTitleNode"
        
        scene.addChild(gameTitle)
        
        //Init play button
        createPlayButton()
        showMenu()
        
    }
    
    
    private func createPlayButton() {
        let width = 250
        let height = 100
        let cornerRadius:CGFloat = CGFloat(40)
        let outerX = width / -2
        let outerY = Int(scene.size.height / 5)
        
        let outerRect: CGRect = CGRect(x: outerX, y: outerY, width: width, height: height)
        playButton.outerShape = SKShapeNode(rect: outerRect, cornerRadius: cornerRadius + 10)
        playButton.outerShape.zPosition = 1
        playButton.outerShape.fillColor = SKColor.black
        
        
        let xOffset = 7
        let yOffset = 7
        let innerWidth = width - (xOffset * 2)
        let innerHeight = height - (yOffset * 2)
        let innerRect: CGRect = CGRect(x: outerX + xOffset, y: outerY + yOffset, width: innerWidth, height: innerHeight)
        playButton.innerShape = SKShapeNode(rect: innerRect, cornerRadius: cornerRadius)
        playButton.innerShape.fillColor = SKColor.white
        playButton.innerShape.zPosition = 1
        
        playButton.textLabel = SKLabelNode(fontNamed: fontName)
        playButton.textLabel.text = "Play"
        playButton.textLabel.fontSize = 50
        playButton.textLabel.fontColor = SKColor.black
        playButton.textLabel.zPosition = 1
        playButton.textLabel.position = CGPoint(x: 0, y: outerY + innerHeight/3 + yOffset)
        playButton.textLabel.isHidden = false
        
        scene.addChild(playButton.outerShape)
        scene.addChild(playButton.innerShape)
        scene.addChild(playButton.textLabel)
    }
    
}
