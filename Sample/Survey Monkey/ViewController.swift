//
//  ViewController.swift
//  Survey Monkey
//
//  Created by Mayank Gupta on 05/10/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionView: RNQuestionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let questions = [ RNQuestion(question: "What is your name?", options: ["Mayank", "Reetika", "Neha", "Jai"], type: .singleChoice),
                                   RNQuestion(question: "What is your age?", options: ["30", "28", "22", "19", "17"], type: .singleChoice),
                                   RNQuestion(question: "What are your hobbies?", options: ["Programming", "Books", "Movies", "Travelling"], type: .multipleChoice)
            
            ] as? [RNQuestion]
        
        questionView.questions = questions
        
        addAccessibility()
    }
}

extension ViewController {
    func addAccessibility() {
        //Question View
        self.questionView.isAccessibilityElement = true
        self.questionView.accessibilityTraits = UIAccessibilityTraitNone
        self.questionView.accessibilityLabel = "Please answer the question"
    }
}
