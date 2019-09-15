//
//  MenuCreator.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import SpriteKit

class MenuCreator {
    
    static let fontName:String = "ArialRoundedMTBold"

    
    var scene:SKScene
    
    var gameTitle:SKLabelNode = SKLabelNode(fontNamed: fontName)
    var bestScore:SKLabelNode = SKLabelNode(fontNamed: fontName)
    var playButton:ButtonComponents = ButtonComponents()
    var levelButton:ButtonComponents = ButtonComponents()
    
    
    struct ButtonComponents {
        var outerShape:SKShapeNode!
        var innerShape:SKShapeNode!
        var textLabel:SKLabelNode!
    }
    
    public init(scene: SKScene) {
        self.scene = scene
        
        initMainMenu()
        showMenu()
    }
    
    func showMenu() {
        playButton.innerShape.isHidden = false
        playButton.outerShape.isHidden = false
        playButton.textLabel.isHidden = false

        levelButton.innerShape.isHidden = false
        levelButton.outerShape.isHidden = false
        levelButton.textLabel.isHidden = false
        
        gameTitle.isHidden = false
        bestScore.isHidden = false
    }
    
    
    //MARK: Private methods
    
    private func initMainMenu() {
        scene.backgroundColor = SKColor.lightGray
        
        //Init game title
        gameTitle.zPosition = 1
        gameTitle.position = CGPoint(x: 0, y: scene.size.height / 3)
        gameTitle.text = "ARCANOID"
        gameTitle.fontColor = SKColor.red
        gameTitle.fontSize = 60
        gameTitle.name = MenuManager.NodeName.gameTitle
        gameTitle.isHidden = true
        
        scene.addChild(gameTitle)
        
        //Init play button
        createButton(text: "Play", name: MenuManager.NodeName.playButton, mainOffset: 0, obj: &playButton)
        createButton(text: "Level", name: MenuManager.NodeName.choseButton, mainOffset: 150, obj: &levelButton)
        
        //Init score label
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: -(scene.size.height/2) + 100)
        bestScore.fontSize = 50
        bestScore.fontColor = SKColor.gray
        bestScore.text = "Best score: 0"
        bestScore.name = MenuManager.NodeName.scoreLabel
        bestScore.isHidden = true
        
        scene.addChild(bestScore)
    }
    
    
    private func createButton(text: String, name: String, mainOffset: Int, obj: inout ButtonComponents) {
        let width = 250
        let height = 100
        let cornerRadius:CGFloat = CGFloat(40)
        let outerX = width / -2
        let outerY = Int(scene.size.height / 10)
        
        //Create outer shape (border)
        let outerRect: CGRect = CGRect(x: outerX, y: outerY - mainOffset, width: width, height: height)
        obj.outerShape = SKShapeNode(rect: outerRect, cornerRadius: cornerRadius + 10)
        obj.outerShape.zPosition = 1
        obj.outerShape.fillColor = SKColor.black
        obj.outerShape.name = name
        
        //Create inner shape
        let xOffset = 7
        let yOffset = 7
        let innerWidth = width - (xOffset * 2)
        let innerHeight = height - (yOffset * 2)
        let innerRect: CGRect = CGRect(x: outerX + xOffset, y: outerY + yOffset - mainOffset, width: innerWidth, height: innerHeight)
        obj.innerShape = SKShapeNode(rect: innerRect, cornerRadius: cornerRadius)
        obj.innerShape.fillColor = SKColor.white
        obj.innerShape.zPosition = 1
        
        //Create text label in the center
        obj.textLabel = SKLabelNode(fontNamed: MenuCreator.fontName)
        obj.textLabel.text = text
        obj.textLabel.fontSize = 50
        obj.textLabel.fontColor = SKColor.black
        obj.textLabel.zPosition = 1
        obj.textLabel.position = CGPoint(x: 0, y: outerY + innerHeight/3 + yOffset - mainOffset)
        
        obj.outerShape.isHidden = true
        obj.innerShape.isHidden = true
        obj.textLabel.isHidden = true
        
        scene.addChild(obj.outerShape)
        scene.addChild(obj.innerShape)
        scene.addChild(obj.textLabel)
    }
    
}
