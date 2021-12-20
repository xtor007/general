//
//  GameVC.swift
//  general
//
//  Created by Anatoliy Khramchenko on 11.12.2021.
//

import UIKit

class GameVC: UIViewController {
    
    let diceRange = 1...6
    var player = 0
    var indexesForRole = [0,1,2,3,4]
    var round = 1
    let buttonNames = ["Role the dice","To next player"]
    var moveIndex = 0
    
    @IBOutlet var dicesTitleImg: [UIImageView]!
    @IBOutlet var dicesPersonImg: [UIImageView]!
    @IBOutlet var dicesComp1Img: [UIImageView]!
    @IBOutlet var dicesComp2Img: [UIImageView]!
    @IBOutlet var diceBut: [UIButton]!
    @IBOutlet weak var nextActionBut: UIButton!
    
    @IBOutlet weak var nowCountP: UILabel!
    @IBOutlet weak var nowCountC1: UILabel!
    @IBOutlet weak var nowCountC2: UILabel!
    @IBOutlet weak var nowCombP: UILabel!
    @IBOutlet weak var nowCombC1: UILabel!
    @IBOutlet weak var nowCombC2: UILabel!
    @IBOutlet weak var sumP: UILabel!
    @IBOutlet weak var sumC1: UILabel!
    @IBOutlet weak var sumC2: UILabel!
    @IBOutlet weak var raundLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        nextActionBut.setTitle(buttonNames[moveIndex%2], for: .normal)
        setEmpty()
    }

    @IBAction func nextAction(_ sender: Any) {
        if moveIndex % 2 == 0 {
            for i in indexesForRole {
                let diceValue = Int.random(in: diceRange)
                let imgName = String(diceValue)
                dicesTitleImg[i].image = UIImage(named: imgName)
            }
            let playerIndex = player % 3
            switch playerIndex {
                case 0: personMove()
                case 1: comp1Move()
                case 2: comp2Move()
                default: break
            }
            player += 1
            round = player / 3 + 1
            if round > 1 {
                clearColor()
                indexesForRole = []
            }
            moveIndex += 1
            nextActionBut.setTitle(buttonNames[moveIndex%2], for: .normal)
        } else {
            let playerIndex = player % 3
            switch playerIndex {
                case 0: personRep()
                case 1: comp1Rep()
                case 2: comp2Rep()
                default: break
            }
            moveIndex += 1
            nextActionBut.setTitle(buttonNames[moveIndex%2], for: .normal)
        }
    }
    
    @IBAction func selectDice(_ sender: Any) {
        if round == 1 || moveIndex == 1 {
            return
        }
        let tapButton = sender as! UIButton
        let index = tapButton.tag
        if !indexesForRole.contains(index-1) {
            tapButton.backgroundColor =  UIColor.blue
            indexesForRole.append(index-1)
        } else {
            tapButton.backgroundColor = UIColor.clear
            indexesForRole.remove(at: indexesForRole.firstIndex(of: index-1)!)
        }
    }
    
    private func clearColor() {
        for i in 0..<5 {
            diceBut[i].backgroundColor = UIColor.clear
        }
    }
    
    private func personMove() {
        for i in 0..<5 {
            dicesPersonImg[i].image = dicesTitleImg[i].image
        }
    }
    
    private func comp1Move() {
        for i in 0..<5 {
            dicesComp1Img[i].image = dicesTitleImg[i].image
        }
    }
    
    private func comp2Move() {
        for i in 0..<5 {
            dicesComp2Img[i].image = dicesTitleImg[i].image
        }
    }
    
    private func personRep() {
        for i in 0..<5 {
            dicesTitleImg[i].image = dicesPersonImg[i].image
        }
    }
    
    private func comp1Rep() {
        for i in 0..<5 {
            dicesTitleImg[i].image = dicesComp1Img[i].image
        }
    }
    
    private func comp2Rep() {
        for i in 0..<5 {
            dicesTitleImg[i].image = dicesComp2Img[i].image
        }
    }
    
    private func setEmpty() {
        nowCountP.text = ""
        nowCountC1.text = ""
        nowCountC2.text = ""
        nowCombP.text = ""
        nowCombC1.text = ""
        nowCombC2.text = ""
        sumP.text = ""
        sumC1.text = ""
        sumC2.text = ""
    }
    
}
