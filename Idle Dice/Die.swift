//
//  Die.swift
//  Idle Dice
//
//  Created by Wesley Dashner on 1/19/20.
//  Copyright © 2020 Wesley Dashner. All rights reserved.
//

import Foundation
import UIKit

struct Die {
    var view = UIImageView(image: UIImage(named: "one"))
    var value = 1
    var doKeep = false
    
    mutating func roll(sixPercentChance: Int) {
        if (!doKeep) {
            value = getRandomNum(sixPercentChance: sixPercentChance)
            view.image = UIImage(named: getNumberWord(num: value))
        }
    }
    
    mutating func toggleKeep() {
        setKeep(doKeep: !doKeep)
    }
    
    mutating func setKeep(doKeep: Bool) {
        self.doKeep = doKeep
        if doKeep {
            view.layer.borderWidth = 4
        } else {
            view.layer.borderWidth = 0
        }
    }
    
    func getRandomNum(sixPercentChance: Int) -> Int {
        var nums: [Int] = Array(repeating: 6, count: sixPercentChance)
        let remainingCount = 100 - sixPercentChance
        var current = 5
        for _ in 0..<remainingCount {
            nums.append(current)
            if current == 1 {
                current = 5
            } else {
                current -= 1
            }
        }
        return nums.randomElement()!
    }
    
    func getNumberWord(num: Int) -> String {
        switch num {
            case 1: return "one"
            case 2: return "two"
            case 3: return "three"
            case 4: return "four"
            case 5: return "five"
            case 6: return "six"
            default: return "ERROR: getNumberWord default"
        }
    }
}

class DieTapGesture: UITapGestureRecognizer {
    var dieIndex = -1
}
