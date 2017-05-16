//
//  Answer.swift
//  iQuiz
//
//  Created by studentuser on 5/7/17.
//  Copyright © 2017 Ethan McGregor. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var currentTopic : item?
    var currentQuestion : QuestionObject?
    var subjectTopic : [item] = []
    var questionPointer = 0
    var correctCount = 0
    var selected = "0"
    var topicNum = 0
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if ( selected == (currentQuestion?.Answer[(currentQuestion?.correctAnswer)! - 1])! ) {
            resultLabel.text = "You are Correct!"
            correctCount += 1
        } else {
            resultLabel.text = "Sorry,You are Wrong"
        }
        correctLabel.text = "Answer is: \(String((currentQuestion?.Answer[(currentQuestion?.correctAnswer)! - 1])!)!  )"
        
        if (questionPointer < (currentTopic?.questions.count)! - 1) {
            nextButton.setTitle("Next", for: UIControlState.normal)
        } else {
            nextButton.setTitle("Finished", for: UIControlState.normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toNextScore(_ sender: AnyObject) {
        if (questionPointer < (currentTopic?.questions.count)! - 1) {
            questionPointer += 1
            performSegue(withIdentifier: "QuestionView", sender: self)
        } else {
            performSegue(withIdentifier: "ScoreView", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ScoreView") {
            let controller = segue.destination as! ScoreViewController
            controller.correctCount = correctCount
            controller.numQuestions = (currentTopic?.questions.count)!
        } else {
            let controller = segue.destination as! QuestionViewController
            controller.questionPointer = questionPointer
            controller.correctCount = correctCount
            controller.topicNum = topicNum
            controller.currentTopic = currentTopic
            controller.currentQuestion = currentQuestion
            controller.subjectTopic = subjectTopic

        }
    }
    
    
}
