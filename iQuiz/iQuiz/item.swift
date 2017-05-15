//
//  item.swift
//  iQuiz
//
//  Created by studentuser on 5/15/17.
//  Copyright © 2017 Ethan McGregor. All rights reserved.
//

import Foundation
import UIKit

class item: NSObject {
    
    var questions : [QuestionObject] = []
    var subjectTitle : String = ""
    var descriptionText : String = ""
    var icon : String = ""
    var iconImage : UIImage?
    
    
    init(_ subject : String, _ description : String, _ icon : String){
        subjectTitle = subject
        descriptionText = description
        self.icon = icon
    }
    
}
