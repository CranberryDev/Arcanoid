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
        createButton(text: "Play", name: "playButtonNode", mainOffset: 0, obj: &playButton)
        createButton(text: "Level", name: "choseLevelNode", mainOffset: 150, obj: &levelButton)
        showMenu()
        
    }
    
    
    private func createButton(text: String, name: String, mainOffset: Int, obj: inout ButtonComponents) {
        let width = 250
        let height = 100
        let cornerRadius:CGFloat = CGFloat(40)
        let outerX = width / -2
        let outerY = Int(scene.size.height / 5)
        
        let outerRect: CGRect = CGRect(x: outerX, y: outerY - mainOffset, width: width, height: height)
        obj.outerShape = SKShapeNode(rect: outerRect, cornerRadius: cornerRadius + 10)
        obj.outerShape.zPosition = 1
        obj.outerShape.fillColor = SKColor.black
        obj.outerShape.name = name
        
        
        let xOffset = 7
        let yOffset = 7
        let innerWidth = width - (xOffset * 2)
        let innerHeight = height - (yOffset * 2)
        let innerRect: CGRect = CGRect(x: outerX + xOffset, y: outerY + yOffset - mainOffset, width: innerWidth, height: innerHeight)
        obj.innerShape = SKShapeNode(rect: innerRect, cornerRadius: cornerRadius)
        obj.innerShape.fillColor = SKColor.white
        obj.innerShape.zPosition = 1
        
        obj.textLabel = SKLabelNode(fontNamed: fontName)
        obj.textLabel.text = text
        obj.textLabel.fontSize = 50
        obj.textLabel.fontColor = SKColor.black
        obj.textLabel.zPosition = 1
        obj.textLabel.position = CGPoint(x: 0, y: outerY + innerHeight/3 + yOffset - mainOffset)
        obj.textLabel.isHidden = false
        
        scene.addChild(obj.outerShape)
        scene.addChild(obj.innerShape)
        scene.addChild(obj.textLabel)
    }
    
}
