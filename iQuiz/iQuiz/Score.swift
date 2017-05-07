//
//  Score.swift
//  iQuiz
//
//  Created by studentuser on 5/7/17.
//  Copyright © 2017 Ethan McGregor. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var numQuestions = 0
    var correctCount = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scoreLabel.text = "You got \(correctCount) out of \(numQuestions)!"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   }
