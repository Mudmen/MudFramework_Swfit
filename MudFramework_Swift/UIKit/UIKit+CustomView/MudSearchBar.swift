//
//  MudSearchBar.swift
//  Travel
//
//  Created by TimTiger on 10/19/15.
//  Copyright © 2015 Mudmen. All rights reserved.
//

import UIKit

protocol MudSearchBarDelegate: NSObjectProtocol {
    func searchBar(searchBar: MudSearchBar,searchDidSelected text: String?)
    func searchBar(searchBar: MudSearchBar,cancelDidSelected text: String?)
}

class MudSearchBar: UIView,UITextFieldDelegate {

    var stextField: UITextField!
    private var scancelButton: UIButton!
    
    weak var delegate : MudSearchBarDelegate?
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.stextField = UITextField()
        self.stextField.delegate = self
        self.stextField.tintColor = UIColor.grayColor()
        self.stextField.returnKeyType = UIReturnKeyType.Search
        self.stextField.textColor = UIColor.blueColor()
        self.stextField.font = UIFont.boldSystemFontOfSize(24)
//     self.stextField.attributedPlaceholder = NSMutableAttributedString(string:  MudLocalString.stringForKey("LBSFilterPlaceholder"), attributes: [NSFontAttributeName: TravelTopicFont,NSForegroundColorAttributeName: TravelGrayColor])
        let leftView = UIView(frame: CGRectMake(0,0,34,11.5))
        let leftSearchView = UIImageView(frame: CGRectMake(15,0,11,11.5))
        leftSearchView.image = UIImage(named: "lbs_filter_left.png")
        leftSearchView.contentMode = UIViewContentMode.Center
        leftView.backgroundColor = UIColor.clearColor()
        leftSearchView.backgroundColor = UIColor.clearColor()
        leftView.addSubview(leftSearchView)
        self.stextField.leftView = leftView
        self.stextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.stextField.leftViewMode = UITextFieldViewMode.Always
        self.stextField.background = UIImage(named: "lbs_searchbg.png")?.stretchableImageWithLeftCapWidth(25, topCapHeight: 15)
        self.addSubview(self.stextField)
        
        self.scancelButton = UIButton(type: UIButtonType.Custom)
        self.scancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.scancelButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.scancelButton.setTitle(MudLocalString.stringForKey("CancelTitle"), forState: UIControlState.Normal)
        self.scancelButton.addTarget(self, action: #selector(MudSearchBar.cancelButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.scancelButton)
        
        let width = self.frame.size.width
        let cancelSize = self.scancelButton.sizeThatFits(CGSizeMake(200, 44))
        let cancelWidth = cancelSize.width
        let textFieldWidth = width-cancelSize.width-10
        self.stextField.frame = CGRectMake(0,7,textFieldWidth,30)
        self.scancelButton.frame = CGRectMake(width-cancelWidth,0,cancelWidth,44)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func cancelButtonAction(sender: UIButton) {
        sender.enabled = false
        self.stextField.resignFirstResponder()
        if self.delegate != nil  {
            self.delegate?.searchBar(self, cancelDidSelected: self.stextField.text)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.stextField.resignFirstResponder()
        if delegate != nil  {
            self.delegate?.searchBar(self, searchDidSelected: self.stextField.text)
        }
        return true
    }
    
}
