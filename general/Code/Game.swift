//
//  Game.swift
//  general
//
//  Created by Anatoliy Khramchenko on 20.12.2021.
//

import Foundation

class Game {
    
    var points = [0,0,0]
    var combin = ["-","-","-"]
    
    private var comp1: [Int] = []
    private var comp2: [Int] = []
    private var per: [Int] = []
    private var is1 = true
    
    func comp1MoveVal() -> [Int] {
        let pos = Position(inNowPlayer: 1, inNowPos: [per,comp1,comp2], inNowDepth: 0)
        pos.toTree()
        for varMove in pos.children {
            if pos.values == varMove.values && varMove.mChangePos != nil {
                return varMove.mChangePos!
            }
        }
        return []
    }
    
    func comp2MoveVal() -> [Int] {
        let pos = Position(inNowPlayer: 2, inNowPos: [per,comp1,comp2], inNowDepth: 0)
        pos.toTree()
        for varMove in pos.children {
            if pos.values == varMove.values && varMove.mChangePos != nil {
                return varMove.mChangePos!
            }
        }
        return []
    }
    
    func perMove(newVal: [Int]) {
        if per != newVal {
            per = newVal
            combin[0] = Combination.getCombo(comb: newVal)
            points[0] = Combination.getPoints(comb: combin[0], is1: is1)
        }
    }
    
    func comp1Move(newVal: [Int]) {
        if comp1 != newVal {
            comp1 = newVal
            combin[1] = Combination.getCombo(comb: newVal)
            points[1] = Combination.getPoints(comb: combin[1], is1: is1)
        }
    }
    
    func comp2Move(newVal: [Int]) {
        if comp2 != newVal {
            comp2 = newVal
            combin[2] = Combination.getCombo(comb: newVal)
            points[2] = Combination.getPoints(comb: combin[2], is1: is1)
        }
        is1 = false
    }
    
    func newRound() {
        points = [0,0,0]
        combin = ["-","-","-"]
        is1 = true
    }
}
