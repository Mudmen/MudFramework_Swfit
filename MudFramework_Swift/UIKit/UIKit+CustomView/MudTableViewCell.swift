//
//  MudTableViewCell.swift
//  Travel
//
//  Created by TimTiger on 15/4/9.
//  Copyright (c) 2015年 Mudmen. All rights reserved.
//

import UIKit

public class MudTableViewCell: UITableViewCell {
    private var cellLine: UIView?
    public var showCellLine: Bool? = false
    public var lineColor: UIColor?
    public var lineEdge: UIEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setCellLineView()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setCellLineView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setCellLineView()
    }
    
    private func setCellLineView() {
        if cellLine == nil {
            cellLine = UIView(frame: CGRectMake(0, 0, self.bounds.size.width, 0.5))
            self.addSubview(cellLine!)
        }
    }
 
    override public func layoutSubviews() {
        super.layoutSubviews()
        cellLine?.frame = CGRectMake(lineEdge.left, self.bounds.size.height-0.5, self.bounds.size.width-lineEdge.left-lineEdge.right, 0.5)
        self.bringSubviewToFront(cellLine!)
        cellLine?.hidden = !showCellLine!
        if self.lineColor != nil {
            cellLine?.backgroundColor = self.lineColor
        }
    }

}
