//
//  ViewController.swift
//  iQuiz
//
//  Created by Ethan McGregor on 5/1/17.
//  Copyright © 2017 Ethan McGregor. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SystemConfiguration
import SwiftyJSON

class questionList {
    var questions = [""]
    var choices = [[""]]
    var answers = [""]
    var questionPointer = 0
    var correctCount = 0
}



class ViewController: UITableViewController {
    
    var questionPointer = 0
    var correctCount = 0
    
    var subjectList : [item] = []
    var subjectNum = 0
    var row = ""
    var userDefaults = UserDefaults.standard

    let url = URL(string: "https://tednewardsandbox.site44.com/questions.json")


    
    
    @IBOutlet weak var settings: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
    }
    
    func isInternetAvailable() -> Bool{
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func loadData(){
        let url = URL(string: "https://tednewardsandbox.site44.com/questions.json")
        
        questionPointer = 0
        correctCount = 0
        subjectList = []
        subjectNum = 0
        row = ""
        userDefaults = UserDefaults.standard
        
        if(isInternetAvailable()){
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: Selector(("loadData")), for: UIControlEvents.valueChanged)
            self.refreshControl = refreshControl
            
            Alamofire.request(url!).responseJSON{ response in
                debugPrint(response)
                
                let pics = ["science","marvel", "math"]
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
                        
                        self.subjectList.append(item(title, description, pics[index]))
                        self.subjectList[index].questions = questionList
                    }
                    let defaults = UserDefaults.standard
                    defaults.setValue(json, forKey: "json")
                }
                

                
                if (self.refreshControl?.isRefreshing)!{
                    
                    self.refreshControl?.endRefreshing()
                }
                self.tableView.reloadData()
            }
        }else{
            questionPointer = 0
            correctCount = 0
            subjectList = []
            subjectNum = 0
            row = ""
            
            let js = UserDefaults.standard.value(forKey: "json") as! [[String:Any]]
            let pics = ["science","marvel", "math"]
            
            for index in 0...js.count - 1{
                
                let title = js[index]["title"] as! String
                let description = js[index]["desc"] as!String
                let questions = js[index]["questions"] as! [[String:Any]]
                var questionList : [QuestionObject] = []
                for num in 0...questions.count - 1{
                    
                    let question = questions[num]["text"] as! String
                    let correctAnswer = questions[num]["answer"] as! String
                    let answers = questions[num]["answers"] as! [String]
                    questionList.append(QuestionObject(Int(correctAnswer)!, question, answers))
                }
                
                self.subjectList.append(item(title, description, pics[index]))
                self.subjectList[index].questions = questionList
            }
            self.tableView.reloadData()

        }
       
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return subjectList.count
    }
    
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iQuizCell", for: indexPath) as! iQuizTableViewCell
        print("cell # \(indexPath.row) selected")

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

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                row = ("cell # \(indexPath.row) selected")
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as! QuestionViewController
        controller.questionPointer = questionPointer
        controller.correctCount = correctCount
        
        let path = self.tableView.indexPathForSelectedRow! [1] + 0
        
        print(path)
        
        //NEW
        let questionView = segue.destination as! QuestionViewController
        questionView.subjectTopic = subjectList
        questionView.topicNum = Int(path)
        
        
    }

    @IBAction func openSettings(_ sender: AnyObject) {
        let settingsController = UIAlertController(title: "Settings go here", message: "", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        settingsController.addAction(defaultAction)
        
        present(settingsController, animated: true, completion: nil)
    }
    
    
}
extension NSObject {
    static func storeJSON(dataToStore: [String: AnyObject], completion: (_ data: NSData?) -> Void) {
        do {
            let data = try JSONSerialization.data(withJSONObject: dataToStore, options: [])
            completion(data as NSData)
        } catch let error as NSError {
            print("NSJSONSerialization Error: \(error)")
            completion(nil)
        }
    }
}

