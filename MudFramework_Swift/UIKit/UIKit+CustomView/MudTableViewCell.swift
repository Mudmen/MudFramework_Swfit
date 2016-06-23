//
//  MudTableViewCell.swift
//  Travel
//
//  Created by TimTiger on 15/4/9.
//  Copyright (c) 2015年 Mudmen. All rights reserved.
//

import UIKit

public class MudTableViewCell: UITableViewCell {
    
    /// 数据模型
    public var cellObject: AnyObject! {
        didSet {
            if cellObject != nil {
                self.updateCellWithObject(cellObject)
            }
        }
    }
    
    /// 是否显示分割线
    public var showCellLine: Bool? = false
    /// 分割线颜色
    public var lineColor: UIColor?
    /// 分割线的Edge
    public var lineEdge: UIEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    
    private var cellLine: UIView?
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initContentViews()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        self.initContentViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initContentViews()
    }
    
    private func setCellLineView() {
        if cellLine == nil {
            cellLine = UIView(frame: CGRectMake(0, 0, self.bounds.size.width, 0.5))
            self.addSubview(cellLine!)
        }
    }
 
    //MARK: - 
    /**
     cell应该显示的高度
     
     - parameter mode: 数据模型
     
     - returns: 返回高度
     */
    public class func cellHeightWithMode(mode: AnyObject)->CGFloat {
        return 45
    }
    
    /**
     更新cell的显示
     
     - parameter object: 数据
     */
    public func updateCellWithObject(object: AnyObject?) {
        
    }
    
    /**
     初始化子视图
     */
    public func initContentViews() {
        self.setCellLineView()
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
