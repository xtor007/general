//
//  Position.swift
//  general
//
//  Created by Anatoliy Khramchenko on 23.12.2021.
//

import Foundation

class Position {
    
    private let maxDepth = 2
    private let allVariants = [
        [],
        [0],[1],[2],[3],[4],
        [0,1],[0,2],[0,3],[0,4],
        [1,2],[1,3],[1,4],
        [2,3],[2,4],
        [3,4],
        [0,1,2],[0,1,3],[0,1,4],
        [0,2,3],[0,2,4],
        [0,3,4],
        [1,2,3],[1,2,4],
        [1,3,4],
        [2,3,4],
        [0,1,2,3], [0,1,2,4],
        [0,1,3,4],
        [0,2,3,4],
        [1,2,3,4],
        [0,1,2,3,4]
    ]
    
    var children: [Position] = []
    private var nowPlayer: Int
    private var nowPos: [[Int]]
    var values = [0.0,0.0,0.0]
    private var flag = true
    private var nowDepth: Int
    var mChangePos: [Int]?
    
    init(inNowPlayer: Int, inNowPos: [[Int]], inNowDepth: Int) {
        nowPlayer = inNowPlayer
        nowPos = inNowPos
        nowDepth = inNowDepth
    }
    
    func toTree() {
        if nowDepth == maxDepth {
            treeEnd()
            return
        }
        for variant in allVariants {
            let child = Position(inNowPlayer: nowPlayer, inNowPos: nowPos, inNowDepth: nowDepth+1)
            children.append(child)
            children[children.count-1].toRanTree(changePos: variant)
            if flag || countKoef(val: values) < countKoef(val: children[children.count-1].values) {
                values = children[children.count-1].values
                flag = false
            }
        }
    }
    
    func toRanTree(changePos: [Int]) {
        mChangePos = changePos
        let chance = pow((1/6), Double(changePos.count))
        var k: [[Int]] = [[nowPos[nowPlayer][0]],[nowPos[nowPlayer][1]],[nowPos[nowPlayer][2]],[nowPos[nowPlayer][3]],[nowPos[nowPlayer][4]]]
        for i in changePos {
            k[i] = [1,2,3,4,5,6]
        }
        for k0 in k[0] {
            for k1 in k[1] {
                for k2 in k[2] {
                    for k3 in k[3] {
                        for k4 in k[4] {
                            var newPos = nowPos
                            newPos[nowPlayer] = [k0,k1,k2,k3,k4]
                            let child = Position(inNowPlayer: (nowPlayer+1)%3, inNowPos: newPos, inNowDepth: nowDepth+1)
                            children.append(child)
                            children[children.count-1].toTree()
                            for i in 0...2 {
                                if chance == 0 {
                                    values[i] += children[children.count-1].values[i]
                                } else {
                                    values[i] += children[children.count-1].values[i]*chance
                                }
                            }
                        }
                    }
                }
            }
        }

    }
    
    private func treeEnd() {
        for i in 0...2 {
            values[i] = Double(Combination.getPoints(comb: Combination.getCombo(comb: nowPos[i]), is1: false))
        }
    }
    
    private func countKoef(val: [Double]) -> Double {
        return val[nowPlayer] - val[(nowPlayer+1)%3] - val[(nowPlayer+2)%3]
    }
    
}
