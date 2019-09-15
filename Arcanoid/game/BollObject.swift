//
//  BollObject.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import Foundation
import SpriteKit

class BollObject {
    
    var boll: SKShapeNode!
    var direction:(x:Double, y:Double)!
    
    public init(boll:SKShapeNode, xVector:Double, yVector:Double) {
        self.boll = boll
        self.direction = (x: xVector, y: yVector)
    }
    
}
