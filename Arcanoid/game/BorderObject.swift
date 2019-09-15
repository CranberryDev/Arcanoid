//
//  BorderObject.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import Foundation
import SpriteKit

class BorderObject {
    
    var scene:SKScene!
    
    var border: SKShapeNode!
    var leftLine:(p1:CGPoint, p2:CGPoint)
    var topLine:(p1:CGPoint, p2:CGPoint)
    var rightLine:(p1:CGPoint, p2:CGPoint)
    
    
    public init(border:SKShapeNode?,
                leftLine:(p1:CGPoint, p2:CGPoint),
                topLine:(p1:CGPoint, p2:CGPoint),
                rightLine:(p1:CGPoint, p2:CGPoint), scene:SKScene) {
        self.border = border!
        self.leftLine = leftLine
        self.topLine = topLine
        self.rightLine = rightLine
        
        self.scene = scene
        
    }
    
}
