//
//  Question.swift
//  iQuiz
//
//  Created by studentuser on 5/7/17.
//  Copyright © 2017 Ethan McGregor. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    var questions = [""]
    var choices = [[""]]
    var answers = [""]
    var questionPointer = 0
    var correctCount = 0
    var selected = "0"
    
    @IBOutlet weak var q1: UIButton!
    @IBOutlet weak var q2: UIButton!
    @IBOutlet weak var q3: UIButton!
    @IBOutlet weak var q4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        questionLabel.text = questions[questionPointer]
        
        var choiceButtons = [q1, q2, q3, q4]
        for index in 0...3 {
            choiceButtons[index]?.setTitle(choices[questionPointer][index], for: UIControlState.normal)
        }
       
    }
    
    
    @IBAction func selectOption(_ sender: AnyObject) {
        selected = sender.currentTitle!!
        
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        if (selected != "0") {
            performSegue(withIdentifier: "AnswerView", sender: self)
        } else {
            let alertController = UIAlertController(title: "Warning", message: "Must select an option", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! AnswerViewController
        controller.questions = questions
        controller.choices = choices
        controller.answers = answers
        controller.questionPointer = questionPointer
        controller.correctCount = correctCount
        controller.selected = selected
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
