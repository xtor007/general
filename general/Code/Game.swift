//
//  Game.swift
//  general
//
//  Created by Anatoliy Khramchenko on 20.12.2021.
//

import Foundation

class Game {
    
    private var comp1: [Int] = []
    private var comp2: [Int] = []
    private var per: [Int] = []
    
    func comp1MoveVal() -> [Int] {
        return [1]
    }
    
    func comp2MoveVal() -> [Int] {
        return [2,3]
    }
    
    func comp1Move(newVal: [Int]) {
        comp1 = newVal
    }
    
    func comp2Move(newVal: [Int]) {
        comp2 = newVal
    }
    
    func perMove(newVal: [Int]) {
        per = newVal
    }
    
}
