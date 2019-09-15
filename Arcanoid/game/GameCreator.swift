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
    var borders: SKShapeNode!
    
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

        borders = SKShapeNode(path: path)
        borders.lineWidth = CGFloat(lineWidth)
        borders.lineCap = CGLineCap(rawValue: 1)!
        borders.isHidden = false
        borders.strokeColor = .gray
        
        scene.addChild(borders)
        
        //Init gameBoard array
        let columns = 23
        let rows = 44
        let cellMargin = 3
        
        let allX = Int(scene.size.width) - borderMargin*2 - lineWidth*2 - ((columns - 1)*cellMargin)
        let allY = Int(scene.size.height) - borderMargin - bottomSpace - lineWidth
        
        let cellWidth = allX / columns
        let cellHeigth = allY / rows
        
        
        var x = Int(scene.size.width / -2) + borderMargin*2 + lineWidth + cellMargin
        var y = Int(scene.size.height / 2) - borderMargin*2 - lineWidth - cellMargin
        
        gameBorder = SKShapeNode()
        gameBorder.isHidden = true
        for i in 0...columns - 1 {
            var point = CGPoint(x: x, y: y)
            var node = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellHeigth))
            node.strokeColor = .cyan
            node.isHidden = false
            node.position = point
            
            gameBorder.addChild(node)
            x += cellWidth
            x += cellMargin
//            y += cellHeigth
        }
        gameBorder.isHidden = false
        
//        var point:CGPoint = CGPoint(x: x, y: y)
//        var test:SKShapeNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellHeigth))
//        test.strokeColor = .cyan
//        test.isHidden = false
//        test.position = point
//        scene.addChild(test)
        
        scene.addChild(gameBorder)
        
    }
    
}
