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
    
    //MARK: Main menu props
    
    var gameTitle:SKLabelNode = SKLabelNode(fontNamed: fontName)
    var bestScore:SKLabelNode = SKLabelNode(fontNamed: fontName)
    var playButton:ButtonComponent = ButtonComponent()
    var levelButton:ButtonComponent = ButtonComponent()
    
    
    //MARK: Level difficulty props
    
    var backButton:SKShapeNode!
    var easyButton:ButtonComponent = ButtonComponent()
    var mediumButton:ButtonComponent = ButtonComponent()
    var hardButton:ButtonComponent = ButtonComponent()
    
    
    public init(scene: SKScene) {
        self.scene = scene
        
        initMainMenu()
        initLevelDifficultyMenu()
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
    
    
    //MARK: Screen transfer methods
    
    func fromMainMenuToLevelDifficultyMenu() {
        collapseButtonElement(obj: playButton)
        collapseButtonElement(obj: levelButton)
        
        backButton.setScale(0)
        backButton.isHidden = false
        backButton.run(SKAction.scale(to: 1, duration: 0.5))
        
        expandButtonElement(obj: easyButton)
        expandButtonElement(obj: mediumButton)
        expandButtonElement(obj: hardButton)
    }
    
    func fromLevelDifficyltyMenuToMainMenu() {
        collapseButtonElement(obj: easyButton)
        collapseButtonElement(obj: mediumButton)
        collapseButtonElement(obj: hardButton)
        
        expandButtonElement(obj: playButton)
        expandButtonElement(obj: levelButton)
    }
    
    
    //MARK: Private methods
    
    //MARK: Animations
    private func collapseButtonElement(obj: ButtonComponent) {
        obj.innerShape.run(SKAction.scale(to: 0, duration: 0.5))
        obj.outerShape.run(SKAction.scale(to: 0, duration: 0.5))
        obj.textLabel.run(SKAction.scale(to: 0, duration: 0.5), completion: {
            obj.innerShape!.isHidden = true
            obj.outerShape!.isHidden = true
            obj.textLabel!.isHidden = true
        })
    }
    
    private func expandButtonElement(obj: ButtonComponent) {
        obj.innerShape.setScale(0)
        obj.outerShape.setScale(0)
        obj.textLabel.setScale(0)
        
        obj.innerShape.isHidden = false
        obj.outerShape.isHidden = false
        obj.textLabel.isHidden = false
        
        obj.innerShape.run(SKAction.scale(to: 1, duration: 0.5))
        obj.outerShape.run(SKAction.scale(to: 1, duration: 0.5))
        obj.textLabel.run(SKAction.scale(to: 1, duration: 0.5))
    }
    
    //MARK: Init methods
    
    private func initLevelDifficultyMenu() {
        //Create levels buttons
        createButton(text: "Easy", name: MenuManager.NodeName.easyButton, mainOffset: 0, obj: easyButton)
        createButton(text: "Medium", name: MenuManager.NodeName.mediumButton, mainOffset: 150, obj: mediumButton)
        createButton(text: "Hard", name: MenuManager.NodeName.hardButton, mainOffset: 300, obj: hardButton)
        
        //Create back button
        let topPoint: CGPoint = CGPoint(x: 25, y: 20)
        let bottomPoint: CGPoint = CGPoint(x: 25, y: -20)
        let rightPoint: CGPoint = CGPoint(x: 60, y: 0)
        let zeroPoint: CGPoint = CGPoint(x: 0, y: 0)
        let path: CGMutablePath = CGMutablePath()
        path.addLines(between: [topPoint, zeroPoint])
        path.addLines(between: [bottomPoint, zeroPoint])
        path.addLines(between: [zeroPoint, rightPoint])
        
        backButton = SKShapeNode(path: path)
        backButton.zPosition = 1
        backButton.position = CGPoint(x: -(scene.size.width/2) + 50, y: scene.size.height/2 - 250)
        backButton.strokeColor = SKColor.black
        backButton.lineWidth = 7
        backButton.lineCap = CGLineCap(rawValue: 1)!
        backButton.name = MenuManager.NodeName.backButton
        backButton.isHidden = true
        
        self.scene.addChild(backButton)
    }
    
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
        createButton(text: "Play", name: MenuManager.NodeName.playButton, mainOffset: 0, obj: playButton)
        createButton(text: "Level", name: MenuManager.NodeName.choseButton, mainOffset: 150, obj: levelButton)
        
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
    
    
    //MARK: Core methods
    
    private func createButton(text: String, name: String, mainOffset: Int, obj: ButtonComponent) {
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
