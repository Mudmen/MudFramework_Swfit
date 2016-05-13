//
//  MudDatePicker.swift
//  Travel
//
//  Created by TimTiger on 15/12/23.
//  Copyright © 2015年 Mudmen. All rights reserved.
//

import UIKit

public class MudDatePicker: UIView {
    public var picker: UIDatePicker!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.clearColor()
        self.picker = UIDatePicker(frame: CGRectMake(0,self.bounds.size.height-216,self.bounds.size.width,216))
        self.picker.backgroundColor = UIColor.whiteColor()
        self.picker.datePickerMode = UIDatePickerMode.Date
        self.addSubview(self.picker)
        
       let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(MudDatePicker.disMissAction(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    func disMissAction(sender: AnyObject)  {
        self.removeFromSuperview()
    }
}
