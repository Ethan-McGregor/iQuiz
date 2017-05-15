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
    
    var subjectList : [item] = []
    var subjectNum = 0

    
    
    @IBOutlet weak var settings: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://tednewardsandbox.site44.com/questions.json")

        Alamofire.request(url!).responseJSON{ response in
            debugPrint(response)
            
            
            if let json = response.result.value as? [[String:Any]]{
                for index in 0...json.count - 1{
                    let title = json[index]["title"] as! String
                    let description = json[index]["desc"] as!String
                    let questions = json[index]["questions"] as! [[String:Any]]
                    var questionList : [QuestionObject] = []
                    for num in 0...questions.count - 1{
                        let question = questions[num]["text"] as! String
                        let correctAnswer = questions[num]["answer"] as! String
                        let answers = questions[num]["answers"] as! [String]
                        questionList.append(QuestionObject(Int(correctAnswer)!, question, answers))
                    }
                    
                    self.subjectList.append(item(title, description, "mathicon"))
                    self.subjectList[index].questions = questionList
                    
                }
                print("JSON: \(json)")
            }
            self.tableView.reloadData()
        }

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
                return subjectList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iQuizCell", for: indexPath) as! iQuizTableViewCell
            
            let item = self.subjectList[indexPath.row]
            cell.questionLabel.text = item.subjectTitle
            cell.descLabel.text = item.descriptionText
            if item.iconImage != nil{
                cell.iconView.image = item.iconImage!
            } else {
                cell.iconView.image = UIImage(named: item.icon)
            }
            return cell
        }

    
    @IBAction func openSettings(_ sender: AnyObject) {
        let settingsController = UIAlertController(title: "Settings go here", message: "", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        settingsController.addAction(defaultAction)
        
        present(settingsController, animated: true, completion: nil)
    }
    
    
}
