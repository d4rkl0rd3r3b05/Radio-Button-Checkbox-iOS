//
//  RNQuestionView.swift
//  Survey Monkey
//
//  Created by Mayank Gupta on 05/10/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//

import UIKit

public enum RNQUestionType: Int {
    case singleChoice = 1
    case multipleChoice = 2
}

open class RNQuestion {
    fileprivate var question: String
    fileprivate var options: [RNOption]
    fileprivate var type: RNQUestionType
    
    init?(question: String, options: [String], type: RNQUestionType) {
        if question.trimmingCharacters(in: .whitespacesAndNewlines) == "" || options.count == 0 {
            return nil
        }
        
        self.question = question
        self.options = options.map{ RNOption(option: $0) }
        self.type = type
    }
}

class RNOption {
    var option: String
    var isSelected: Bool
    
    init(option: String, isSelected: Bool = false) {
        self.option = option
        self.isSelected = isSelected
    }
}

class IntrinsicTableView: UITableView {
    
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIScreen.main.bounds.width, height: contentSize.height)
    }
    
}

public protocol QuestionSubmissionDelegate: NSObjectProtocol {
    func onSubmission(response: [[Int]])
}

open class RNQuestionView: UIView, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsTableView: IntrinsicTableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var questions: [RNQuestion]?
    var currentQuestionIndex = 0
    var currentQuestionType: RNQUestionType = .singleChoice
    weak var delegate: QuestionSubmissionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpXib()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpXib()
    }
    
    //SetUpXib
    func setUpXib() {
        let view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.addSubview(view)
        
        let podBundle = Bundle(for: RNQuestionOptionCell.self)
        
        let bundleURL = podBundle.url(forResource: "Radio_CheckBox_Framework", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        
        self.optionsTableView.register(UINib(nibName: "RNQuestionOptionCell", bundle: bundle), forCellReuseIdentifier: "RNQuestionOptionCell")
    }
    
    func loadViewFromNib() -> UIView {
        
        let podBundle = Bundle(for: RNQuestionView.self)
        
        let bundleURL = podBundle.url(forResource: "Radio_CheckBox_Framework", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        
        let nib = UINib(nibName: "RNQuestionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentQuestion = self.questions?[currentQuestionIndex] {
            //Calculated once for every question to avoid over calculation
            self.currentQuestionType = currentQuestion.type
            
            if self.currentQuestionType == .multipleChoice {
                self.optionsTableView.allowsMultipleSelection = true
            } else {
                self.optionsTableView.allowsMultipleSelection = false
            }
            
            self.questionLabel.text = currentQuestion.question
            addAccessibility(currentQuestion: currentQuestion)
            
            return currentQuestion.options.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RNQuestionOptionCell", for: indexPath) as! RNQuestionOptionCell
        cell.setData(option: self.questions![currentQuestionIndex].options[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.questions![currentQuestionIndex].options[indexPath.row].isSelected = true
        
//        if currentQuestionType == .singleChoice {
//            self.nextButtonAction(nil)
//        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any?) {
        if self.questions![currentQuestionIndex].options.filter({return $0.isSelected}).count <= 0 {
            return
        }
        
        if self.questions == nil || currentQuestionIndex == self.questions!.count - 1 {
            //TODO: provide callback

            return
        }
        
        currentQuestionIndex += 1
        self.optionsTableView.reloadData()
    }
}

extension RNQuestionView {
    func addAccessibility(currentQuestion: RNQuestion) {
        //Question Label
        self.questionLabel.isAccessibilityElement = true
        self.questionLabel.accessibilityTraits = UIAccessibilityTraitHeader
        self.questionLabel.accessibilityLabel = (self.currentQuestionType == .multipleChoice ? "Multiple Choice Correct " : "Single  Choice Correct ") + currentQuestion.question
        self.questionLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        if #available(iOS 10.0, *) {
            self.questionLabel.adjustsFontForContentSizeCategory = true
        }
    }
}

