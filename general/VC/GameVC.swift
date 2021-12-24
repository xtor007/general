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
    var gameRound = 1
    
    let game = Game()
    
    var values = [[0,0,0,0,0],
    [0,0,0,0,0],
    [0,0,0,0,0]]
    var scoring = [0,0,0]
    
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
    
    
    @IBOutlet var movesView: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        nextActionBut.setTitle(buttonNames[moveIndex%2], for: .normal)
        setEmpty()
        updateScore()
        raundLabel.text = "Round " + String(gameRound)
        for i in 1...2 {
            movesView[i].isHidden = true
        }
    }

    @IBAction func nextAction(_ sender: Any) {
        if moveIndex % 2 == 0 {
            let playerIndex = player % 3
            round = player / 3 + 1
            if round != 1 {
                switch playerIndex {
                    case 1: indexesForRole = game.comp1MoveVal()
                    case 2: indexesForRole = game.comp2MoveVal()
                    default: break
                }
            }
            for i in indexesForRole {
                let diceValue = Int.random(in: diceRange)
//                let imgName = String(diceValue)
//                dicesTitleImg[i].image = UIImage(named: imgName)
                values[playerIndex][i] = diceValue
            }
            setTitleDice(forPlayer: playerIndex)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                switch playerIndex {
                    case 0: self.personMove()
                    case 1: self.comp1Move()
                    case 2: self.comp2Move()
                    default: break
                }
            }
            clearColor()
            moveIndex += 1
            nextActionBut.setTitle(buttonNames[moveIndex%2], for: .normal)
        } else {
            let playerIndex = player % 3
            movesView[playerIndex].isHidden = true
            movesView[(playerIndex+1)%3].isHidden = false
            player += 1
            round = player / 3 + 1
            if round == 4 {
                round = 1
                player = 0
                gameRound += 1
                if gameRound == 11 {
                    isWinner()
                }
                for i in 0...2 {
                    scoring[i] += game.points[i]
                }
                game.newRound()
                updateScore()
                setEmpty()
                raundLabel.text = "Round " + String(gameRound)
            }
            if round == 1 {
                indexesForRole = [0,1,2,3,4]
            } else {
                indexesForRole = []
            }
            //DispatchQueue.main.asyncAfter(deadline: .now() + 0.56) {
            switch playerIndex+1 {
                case 3: self.personRep()
                case 1: self.comp1Rep()
                case 2: self.comp2Rep()
                default: break
            }
            self.moveIndex += 1
            self.nextActionBut.setTitle(self.buttonNames[self.moveIndex%2], for: .normal)
            //}
        }
    }
    
    @IBAction func selectDice(_ sender: Any) {
        if round == 1 || moveIndex == 1 || player % 3 != 0 {
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
        let toGame = values[0]
        for i in 0..<5 {
            dicesPersonImg[i].image = dicesTitleImg[i].image
        }
        game.perMove(newVal: toGame)
        nowCountP.text = String(game.points[0])
        nowCombP.text = game.combin[0]
    }
    
    private func comp1Move() {
        let toGame = values[1]
        for i in 0..<5 {
            dicesComp1Img[i].image = dicesTitleImg[i].image
        }
        game.comp1Move(newVal: toGame)
        nowCountC1.text = String(game.points[1])
        nowCombC1.text = game.combin[1]
    }
    
    private func comp2Move() {
        let toGame = values[2]
        for i in 0..<5 {
            dicesComp2Img[i].image = dicesTitleImg[i].image
        }
        game.comp2Move(newVal: toGame)
        nowCountC2.text = String(game.points[2])
        nowCombC2.text = game.combin[2]
    }
    
    private func personRep() {
        for i in 0..<5 {
            if round == 1 {
                dicesTitleImg[i].image = nil
                continue
            }
            dicesTitleImg[i].image = dicesPersonImg[i].image
        }
    }
    
    private func comp1Rep() {
        for i in 0..<5 {
            if round == 1 {
                dicesTitleImg[i].image = nil
                continue
            }
            dicesTitleImg[i].image = dicesComp1Img[i].image
        }
    }
    
    private func comp2Rep() {
        for i in 0..<5 {
            if round == 1 {
                dicesTitleImg[i].image = nil
                continue
            }
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
        for i in 0..<dicesPersonImg.count {
            dicesPersonImg[i].image = nil
        }
        for i in 0..<dicesComp1Img.count {
            dicesComp1Img[i].image = nil
        }
        for i in 0..<dicesComp2Img.count {
            dicesComp2Img[i].image = nil
        }
    }
    
    private func isWinner() {
        
    }
    
    private func updateScore() {
        sumP.text = String(scoring[0])
        sumC1.text = String(scoring[1])
        sumC2.text = String(scoring[2])
    }
    
    private func setTitleDice(forPlayer: Int) {
        for time in 0...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05*Double(time)) {
                for i in self.indexesForRole {
                    let diceValue = Int.random(in: self.diceRange)
                    let imgName = String(diceValue)
                    self.dicesTitleImg[i].image = UIImage(named: imgName)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            for i in self.indexesForRole {
                let diceValue = self.values[forPlayer][i]
                let imgName = String(diceValue)
                self.dicesTitleImg[i].image = UIImage(named: imgName)
            }
            return
        }
    }
    
}
