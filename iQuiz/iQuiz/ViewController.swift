//
//  ViewController.swift
//  iQuiz
//
//  Created by Ethan McGregor on 5/1/17.
//  Copyright © 2017 Ethan McGregor. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    let desc = ["Math is fun...?", "Marvel", "SCIENCE!"]
    let icons = [#imageLiteral(resourceName: "math"), #imageLiteral(resourceName: "marvel"), #imageLiteral(resourceName: "science")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iQuizCell", for: indexPath) as! iQuizTableViewCell
        
        // Configure the cell...
        cell.questionLabel.text = subjects[indexPath.row]
        cell.descLabel.text = desc[indexPath.row]
        cell.iconView.image = icons[indexPath.row]
        
        return cell
    }
    
    
    }
