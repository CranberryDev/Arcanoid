//
//  PlayerObject.swift
//  Arcanoid
//
//  Created by Artem Agaev on 15/09/2019.
//  Copyright © 2019 Artem Agaev. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerObject {
    
    var node:SKShapeNode!
    var width:Int
    var heigth:Int
    
    public init(size:CGSize?) {
        self.node = SKShapeNode(rectOf: size!, cornerRadius: 10)
        self.width = Int(size!.width)
        self.heigth = Int(size!.height)
    }

}

