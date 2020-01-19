//
//  ViewController.swift
//  Idle Dice
//
//  Created by Wesley Dashner on 1/18/20.
//  Copyright © 2020 Wesley Dashner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        positionView(parentView: view, subView: UIImageView(image: UIImage(named: "background")!), xRatio: 0.5, yRatio: 0.5, widthRatio: 1, heightRatio: 1)
        positionSquareView(parentView: view, subView: UIImageView(image: UIImage(named: "one")), xRatio: 1/4, yRatio: 1/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: UIImageView(image: UIImage(named: "one")), xRatio: 3/4, yRatio: 1/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: UIImageView(image: UIImage(named: "one")), xRatio: 1/4, yRatio: 2/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: UIImageView(image: UIImage(named: "one")), xRatio: 3/4, yRatio: 2/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: UIImageView(image: UIImage(named: "one")), xRatio: 1/4, yRatio: 3/4, sizeRatioToWidth: 1/3)
        positionSquareView(parentView: view, subView: UIImageView(image: UIImage(named: "one")), xRatio: 3/4, yRatio: 3/4, sizeRatioToWidth: 1/3)
    }
    
    private func getRandomNum() -> String {
        let nums = ["one", "two", "three", "four", "five", "six"]
        return nums.randomElement()!
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

}
