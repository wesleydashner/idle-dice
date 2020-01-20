//
//  ViewController.swift
//  Idle Dice
//
//  Created by Wesley Dashner on 1/18/20.
//  Copyright © 2020 Wesley Dashner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dice: [Die] = []
    let background = UIImageView(image: UIImage(named: "background"))
    let moneyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        loadPlayerObject()
        populateDice()
        setupUI()
        setupGestures()
        roll()
    }
    
    func populateDice() {
        let numOfDice = 6
        for _ in 0..<numOfDice {
            dice.append(Die())
        }
    }
    
    private func setupUI() {
        positionView(parentView: view, subView: background, xRatio: 0.5, yRatio: 0.5, widthRatio: 1, heightRatio: 1)
        positionSquareView(parentView: view, subView: dice[0].view, xRatio: 1/4, yRatio: 1/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: dice[1].view, xRatio: 3/4, yRatio: 1/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: dice[2].view, xRatio: 1/4, yRatio: 2/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: dice[3].view, xRatio: 3/4, yRatio: 2/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: dice[4].view, xRatio: 1/4, yRatio: 3/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: dice[5].view, xRatio: 3/4, yRatio: 3/4, sizeRatioToWidth: 1/3)
        
        positionView(parentView: view, subView: moneyLabel, xRatio: 0.5, yRatio: 0.1, widthRatio: 1, heightRatio: 0.1)
        moneyLabel.textAlignment = .center
        updateMoneyLabel()
    }
    
    private func updateMoneyLabel() {
        moneyLabel.text = "$ \(player.money)"
    }
    
    private func setupGestures() {
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped))
        background.isUserInteractionEnabled = true
        background.addGestureRecognizer(backgroundGesture)
        for i in 0..<dice.count {
            let dieGesture = DieTapGesture(target: self, action: #selector(self.dieTapped))
            dieGesture.dieIndex = i
            dice[i].view.isUserInteractionEnabled = true
            dice[i].view.addGestureRecognizer(dieGesture)
        }
    }
    
    private func loadPlayerObject() {
        player = Storage.retrieve("player.json", from: .documents, as: Player.self)
    }
    
    private func addView(parentView: UIView, subView: UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        subView.frame = CGRect(x: x, y: y, width: width, height: height)
        parentView.addSubview(subView)
    }
    
    // centers subview within parentView at a point that is a ratio of the subview's size
    private func positionView(parentView: UIView, subView: UIView, xRatio: CGFloat, yRatio: CGFloat, widthRatio: CGFloat, heightRatio: CGFloat) {
        let width = parentView.bounds.width * widthRatio
        let height = parentView.bounds.height * heightRatio
        subView.frame.size.width = width
        subView.frame.size.height = height
        let x = parentView.bounds.width * xRatio - subView.bounds.width / 2
        let y = parentView.bounds.height * yRatio - subView.bounds.height / 2
        addView(parentView: parentView, subView: subView, x: x, y: y, width: width, height: height)
    }
    
    private func positionSquareView(parentView: UIView, subView: UIView, xRatio: CGFloat, yRatio: CGFloat, sizeRatioToWidth: CGFloat) {
        let width = parentView.bounds.width * sizeRatioToWidth
        subView.frame.size.width = width
        subView.frame.size.height = width
        let x = parentView.bounds.width * xRatio - subView.bounds.width / 2
        let y = parentView.bounds.height * yRatio - subView.bounds.height / 2
        addView(parentView: parentView, subView: subView, x: x, y: y, width: width, height: width)
    }
    
    private func getRandomNumString() -> String {
        let nums = ["one", "two", "three", "four", "five", "six"]
        return nums.randomElement()!
    }
    
    private func roll() {
        var values: [Int] = []
        for i in 0..<dice.count {
            dice[i].roll(sixPercentChance: player.sixPercentChances[i])
            values.append(dice[i].value)
        }
    }
    
    private func doWin() {
        player.money += dice[0].value
        updateMoneyLabel()
        stopKeepingDice()
        roll()
    }
    
    private func stopKeepingDice() {
        for i in 0..<dice.count {
            dice[i].setKeep(doKeep: false)
        }
    }

    @objc func backgroundTapped() {
        roll()
    }
    
    @objc func dieTapped(sender: DieTapGesture) {
        dice[sender.dieIndex].toggleKeep()
        if isWin() {
            doWin()
        }
    }
    
    private func isWin() -> Bool {
        for die in dice {
            if die.doKeep == false {
                return false
            }
            if die.value != dice[0].value {
                return false
            }
        }
        return true
    }

}
