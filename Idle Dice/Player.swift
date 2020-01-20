//
//  Player.swift
//  Idle Dice
//
//  Created by Wesley Dashner on 1/19/20.
//  Copyright © 2020 Wesley Dashner. All rights reserved.
//

import Foundation

var player = Player()

struct Player: Codable {
    var money = 0 {
        didSet {
            Storage.store(self, to: .documents, as: "player.json")
        }
    }
    var sixPercentChances = [17, 17, 17, 17, 17, 17] {
        didSet {
            Storage.store(self, to: .documents, as: "player.json")
        }
    }
}
