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
        return [1]
    }
    
    func comp2MoveVal() -> [Int] {
        return [2,3]
    }
    
    func perMove(newVal: [Int]) {
        per = newVal
        combin[0] = Combination.getCombo(comb: newVal)
        points[0] = Combination.getPoints(comb: combin[0], is1: is1)
    }
    
    func comp1Move(newVal: [Int]) {
        comp1 = newVal
        combin[1] = Combination.getCombo(comb: newVal)
        points[1] = Combination.getPoints(comb: combin[1], is1: is1)
    }
    
    func comp2Move(newVal: [Int]) {
        comp2 = newVal
        combin[2] = Combination.getCombo(comb: newVal)
        points[2] = Combination.getPoints(comb: combin[2], is1: is1)
        is1 = false
    }
    
    func newRound() {
//        let max = points.max()
//        var winner: [Int] = []
//        for i in 0...2 {
//            if points[i] == max {
//                winner.append(i)
//            }
//        }
        points = [0,0,0]
        combin = ["-","-","-"]
        is1 = true
//        if winner.count == 1 {
//            return winner[0]
//        } else {
//            return -1
//        }
    }
}
