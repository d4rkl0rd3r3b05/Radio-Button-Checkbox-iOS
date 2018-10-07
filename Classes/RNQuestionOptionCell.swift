//
//  RNQuestionOptionCell.swift
//  Survey Monkey
//
//  Created by Mayank Gupta on 05/10/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//

import UIKit

class RNQuestionOptionCell: UITableViewCell {

    @IBOutlet weak var optionSelectionControlImage: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    
    var associatedOption: RNOption?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.associatedOption?.isSelected = selected
        self.optionSelectionControlImage.image = selected ? UIImage(named: "selectedIcon") : UIImage(named: "unselectedIcon")
        addAccessibility(currentOption: self.associatedOption!)
    }
    
    func setData(option: RNOption) {
        self.associatedOption = option
        
        self.optionLabel.text = option.option
        self.isSelected = option.isSelected
        
        addAccessibility(currentOption: option)
    }
    
}

extension RNQuestionOptionCell {
    func addAccessibility(currentOption: RNOption) {
        //Option Label
        self.optionLabel.isAccessibilityElement = true
        self.optionLabel.accessibilityTraits = UIAccessibilityTraits.staticText
        self.optionLabel.accessibilityLabel = currentOption.option + (currentOption.isSelected ? " Selected" : " Not Selected")
        self.optionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.optionLabel.adjustsFontForContentSizeCategory = true
        
        self.optionSelectionControlImage.isAccessibilityElement = false
        if #available(iOS 11.0, *) {
            self.optionSelectionControlImage.accessibilityIgnoresInvertColors = true
        }
    }
}
