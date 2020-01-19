//
//  Player.swift
//  Idle Dice
//
//  Created by Wesley Dashner on 1/19/20.
//  Copyright © 2020 Wesley Dashner. All rights reserved.
//

import Foundation

var player = Player()

class Player: Codable {
    var money: Int
    
    init() {
        money = 0
    }
}
