//
//  Combination.swift
//  general
//
//  Created by Anatoliy Khramchenko on 23.12.2021.
//

import Foundation

class Combination {
    
    static func getCombo(comb: [Int]) -> String {
        var combF = comb
        combF.sort()
        var genFlag = true
        var fourFlag = true
        var fullHouseFlag = true
        var stritFlag = true
        var is1Norm = true
        var is2Norm = true
        for i in 1...4 {
            if combF[i] != combF[i-1] {
                genFlag = false
                if (i != 4 && i != 1) || !is1Norm {
                    fourFlag = false
                }
                if (i != 3 && i != 2) || !is2Norm {
                    fullHouseFlag = false
                }
                if i==1 {
                    is1Norm = false
                }
                if i==2 {
                    is2Norm = false
                }
            }
            if combF[i] != combF[i-1]+1 {
                stritFlag = false
            }
            
        }
        if genFlag {
            return "general"
        }
        if fourFlag {
            return "four"
        }
        if fullHouseFlag {
            return "full house"
        }
        if stritFlag {
            return "strit"
        }
        return "-"
    }
    
    static func getPoints(comb: String, is1: Bool) -> Int {
        let resCount = [[0,0],[60,0],[45,40],[35,30],[25,20]]
        var combNum = 0
        switch comb {
            case "general": combNum = 1
            case "four": combNum = 2
            case "full house": combNum = 3
            case "strit": combNum = 4
            default: combNum = 0
        }
        var moveNum = 1
        if is1 {
            moveNum = 0
        }
        return resCount[combNum][moveNum]
    }
    
}
