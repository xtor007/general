//
//  EndVC.swift
//  general
//
//  Created by Anatoliy Khramchenko on 24.12.2021.
//

import UIKit

class EndVC: UIViewController {
    
    var win = ""
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        winnerLabel.text = win
    }

    @IBAction func close(_ sender: Any) {
        exit(0)
    }
}
