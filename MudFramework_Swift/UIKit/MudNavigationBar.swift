//
//  MudNavigationBar.swift
//  Travel
//
//  Created by TimTiger on 1/27/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

public class MudNavigationBar: UINavigationBar {
    override public func layoutSubviews() {
        super.layoutSubviews()
//        //2.方案二
//        if (IOS_7_BELOW) {
//            return;
//        }
//        
//        NSInteger rightBarButtonItemsCount = self.topItem.rightBarButtonItems.count;
//        if (rightBarButtonItemsCount > 0) {
//            NSMutableArray *rightItems = [NSMutableArray arrayWithArray:self.topItem.rightBarButtonItems];
//            UIBarButtonItem *item = [rightItems objectAtIndex:0];
//            if (item.tag != 299) {
//                UIBarButtonItem *rightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//                rightSpacer.width = -10;
//                rightSpacer.tag = 299;
//                [rightItems insertObject:rightSpacer atIndex:0];
//                self.topItem.rightBarButtonItems = rightItems;
//            }
//        }
//        NSInteger leftBarButtonItemsCount = self.topItem.leftBarButtonItems.count;
//        if (leftBarButtonItemsCount > 0) {
//            NSMutableArray *leftItems = [NSMutableArray arrayWithArray:self.topItem.leftBarButtonItems];
//            UIBarButtonItem *rightItem = [leftItems objectAtIndex:0];
//            if (rightItem.tag != 300) {
//                UIBarButtonItem *leftSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//                leftSpacer.width = -10;
//                leftSpacer.tag = 300;
//                [leftItems insertObject:leftSpacer atIndex:0];
//                self.topItem.leftBarButtonItems = leftItems;
//            }
//        }
        //方案1
        let rightBarButtonItemsCount = self.topItem?.rightBarButtonItems?.count
        if rightBarButtonItemsCount > 0 {
            var rightItems: [UIBarButtonItem] = self.topItem!.rightBarButtonItems!
            let item: UIBarButtonItem = rightItems[0]
            if item.tag != 299 {
                let rightSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil ,action:nil)
                rightSpace.width = -5;
                rightSpace.tag = 299;
                rightItems.insert(rightSpace, atIndex: 0)
                self.topItem!.rightBarButtonItems = rightItems
            }
        }
        let leftBarButtonItemsCount = self.topItem?.leftBarButtonItems?.count
        if leftBarButtonItemsCount > 0 {
            var leftItems: [UIBarButtonItem] = self.topItem!.leftBarButtonItems!
            let item: UIBarButtonItem = leftItems[0]
            if item.tag != 300 {
                let leftSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil ,action:nil)
                leftSpace.width = -5;
                leftSpace.tag = 300;
                leftItems.insert(leftSpace, atIndex: 0)
                self.topItem!.leftBarButtonItems = leftItems
            }
        }
    }
}
