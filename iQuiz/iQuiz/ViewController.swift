//
//  ViewController.swift
//  iQuiz
//
//  Created by Ethan McGregor on 5/1/17.
//  Copyright © 2017 Ethan McGregor. All rights reserved.
//

import UIKit
import Alamofire

class questionList {
    var questions = [""]
    var choices = [[""]]
    var answers = [""]
    var questionPointer = 0
    var correctCount = 0
}

class ViewController: UITableViewController {
    
    let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    let desc = ["You get to do MATH!", "Are you a Marvel buff?", "SCIENCE!!!"]
    let icons = [#imageLiteral(resourceName: "math"), #imageLiteral(resourceName: "marvel"), #imageLiteral(resourceName: "science")]
    let questions = ["Daredevil's disability is...?", "What is 5 * 4"]
    let choices = [["He cant walk", "He is blind", "he has one arm", "he cant talk"], ["1", "20", "0", "pie"]]
    let answers = ["He is blind", "20"]
    var questionPointer = 0
    var correctCount = 0
    
    @IBOutlet weak var settings: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as! QuestionViewController
        controller.questions = questions
        controller.choices = choices
        controller.answers = answers
        controller.questionPointer = questionPointer
        controller.correctCount = correctCount
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return subjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iQuizCell", for: indexPath) as! iQuizTableViewCell
        
        cell.questionLabel.text = subjects[indexPath.row]
        cell.descLabel.text = desc[indexPath.row]
        cell.iconView.image = icons[indexPath.row]
        
        return cell
    }
    
    @IBAction func openSettings(_ sender: AnyObject) {
        let settingsController = UIAlertController(title: "Settings go here", message: "", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        settingsController.addAction(defaultAction)
        
        present(settingsController, animated: true, completion: nil)
    }
    
    
    
}
