//
//  GameCreator.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import Foundation
import SpriteKit

class GameCreator {
    
    var scene: SKScene
    
    
    var gameBorder: SKShapeNode!
    var boardArray: [(node: SKNode, x: Int, y: Int)] = []
    var border:BorderObject!
    var boll:BollObject!
    var player:PlayerObject!
    
    init(scene: SKScene!) {
        self.scene = scene
        
        initGameBoard()
    }
    
    
    
    //MARK: Private methods
    
    private func initGameBoard() {
        //Init borders
        let borderMargin = 10
        let lineWidth = 10
        let bottomSpace = Int(scene.size.height / 20)
        
        let leftBottom = CGPoint(x: Int(scene.size.width / -2) + borderMargin, y: Int(scene.size.height / -2) + borderMargin + bottomSpace)
        let leftTop = CGPoint(x: Int(scene.size.width / -2) + borderMargin, y: Int(scene.size.height / 2) - borderMargin)
        let rightTop = CGPoint(x: Int(scene.size.width / 2) - borderMargin, y: Int(scene.size.height / 2) - borderMargin)
        let rigthBottom = CGPoint(x: Int(scene.size.width / 2) - borderMargin, y: Int(scene.size.height / -2) + borderMargin + bottomSpace)
        
        let path:CGMutablePath = CGMutablePath()
        path.addLines(between: [leftBottom, leftTop])
        path.addLines(between: [leftTop, rightTop])
        path.addLines(between: [rightTop, rigthBottom])

        let borders = SKShapeNode(path: path)
        borders.lineWidth = CGFloat(lineWidth)
        borders.lineCap = CGLineCap(rawValue: 1)!
        borders.strokeColor = .gray
        borders.name = GameManager.NodeName.borderNode
        borders.isHidden = false
        
        border = BorderObject.init(border: borders,
                                   leftLine: (p1: leftBottom, p2: leftTop),
                                   topLine: (p1: leftTop, p2: rightTop),
                                   rightLine: (p1: rightTop, p2: rigthBottom), scene: scene)
        
        scene.addChild(border.border)
        
        //Init gameBoard array
        let columns = 23
        let rows = 44
        let gameRows = 23
        let cellMargin = 3
        
        let allX = Int(scene.size.width) - borderMargin*2 - lineWidth*2 - ((columns - 1)*cellMargin)
        let allY = Int(scene.size.height) - borderMargin - bottomSpace - lineWidth - (rows - 1)*cellMargin
        let cellWidth = allX / columns
        let cellHeigth = allY / rows
        let x = Int(scene.size.width / -2) + borderMargin*2 + lineWidth + cellMargin
        let y = Int(scene.size.height / 2) - borderMargin*2 - lineWidth - cellMargin
        
        gameBorder = SKShapeNode()
        gameBorder.isHidden = true
        var loopY = y
        for j in 0...rows - 1 {
            var loopX = x
            for i in 0...columns - 1 {
                let point = CGPoint(x: loopX, y: loopY)
                let node = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellHeigth))
                node.isHidden = false
                node.position = point
                node.zPosition = 1
                
                //Show node if its in the game area
                if j < gameRows {
                    node.strokeColor = .cyan
                } else {
                    node.strokeColor = .clear
                    node.isHidden = true
                }
                
                boardArray.append((node: node, x: i, y: j))
                gameBorder.addChild(node)
                
                loopX += cellWidth
                loopX += cellMargin
            }
            loopY -= cellHeigth
            loopY -= cellMargin
        }
        scene.addChild(gameBorder)
        
        initPlayer(cellWidth: cellWidth, cellHeigth: cellHeigth, bottomSpace: bottomSpace, cellMargin: cellMargin)
        initBoll(cellWidth: cellWidth, cellHeigth: cellHeigth, bottomSpace: bottomSpace, cellMargin: cellMargin)
    }
    
    
    private func initPlayer(cellWidth:Int, cellHeigth: Int, bottomSpace:Int, cellMargin:Int) {
        let initX = 0
        let initY = Int(scene.size.height / -2) + bottomSpace + cellHeigth
        let width = cellWidth*3
        let heigth = cellHeigth
        
        let node = SKShapeNode(rectOf: CGSize(width: width, height: heigth), cornerRadius: 5)
        node.zPosition = 2
        node.position = CGPoint(x: initX, y: initY)
        node.fillColor = .red
        node.name = GameManager.NodeName.playerNode
        
        player = PlayerObject.init(size: CGSize(width: width, height: heigth))
        player.node = node
        scene.addChild(player.node)
        player.node.isHidden = false
    }
    
    private func initBoll(cellWidth:Int, cellHeigth:Int, bottomSpace:Int, cellMargin:Int) {
        let x = 0
        let y = Int(scene.size.height / -2) + bottomSpace + cellHeigth*2
        let node = SKShapeNode(circleOfRadius: 15)
        node.zPosition = 1
        node.position = CGPoint(x: x, y: y)
        node.fillColor = .green
        node.name = GameManager.NodeName.bollNode
        boll = BollObject.init(boll: node, xVector: 1, yVector: 1)
        scene.addChild(boll.boll)
        boll.boll.isHidden = true
    }
    
}
