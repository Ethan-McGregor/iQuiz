//
//  QuestionObject.swift
//  iQuiz
//
//  Created by studentuser on 5/15/17.
//  Copyright © 2017 Ethan McGregor. All rights reserved.
//

import Foundation

import UIKit

class QuestionObject: NSObject {
    var correctAnswer = 0
    var question = ""
    var Answer : [String] = []
    
    init(_ correctAnswer : Int, _ question : String, _ Answer : [String]){
        self.correctAnswer = correctAnswer
        self.question = question
        self.Answer = Answer
    }
    
}
