//
//  MudLeftImageView.swift
//  Travel
//
//  Created by TimTiger on 6/4/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit

let IMAGE_WIDTH: CGFloat = MUD_SCREEN_WIDTH*0.46875

class MudLeftImageView: UIImageView {
    
    override var image: UIImage? {
        didSet {
            if image != nil {
                self.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    class func  getSizeWithWidth(width: CGFloat,height: CGFloat)->CGSize {
        if width == 0 || height == 0 {
            return CGSizeMake(IMAGE_WIDTH/2, IMAGE_WIDTH/2)
        }
        
        if height/width >= 2 {
            var theight = IMAGE_WIDTH
            if height < theight {
                theight = height
            }
            return CGSizeMake(IMAGE_WIDTH/2,theight)
        }
        
        if width/height >= 2 {
            var twidth = IMAGE_WIDTH
            if width < twidth {
                twidth = width
            }
            return CGSizeMake(twidth,IMAGE_WIDTH/2)
        }
        
        if width <= IMAGE_WIDTH && height <= IMAGE_WIDTH {
            return CGSizeMake(width, height)
        }
        
        var rSize = CGSizeMake(IMAGE_WIDTH, IMAGE_WIDTH)
        if height > width {
            rSize.width = IMAGE_WIDTH/(height/width)
            rSize.height = IMAGE_WIDTH
        } else {
            rSize.height = IMAGE_WIDTH/(width/height)
            rSize.width = IMAGE_WIDTH
        }
        return rSize
    }
    
    class func  sizeWithWidth(timageView: UIImageView,width: CGFloat,height: CGFloat)->CGSize {
        if width == 0 || height == 0 {
            timageView.contentMode = UIViewContentMode.TopLeft
            return CGSizeMake(IMAGE_WIDTH/2, IMAGE_WIDTH/2)
        }
        
        if height/width >= 2 {
            timageView.contentMode = UIViewContentMode.TopLeft
            var theight = IMAGE_WIDTH
            if height < theight {
                theight = height
            }
            return CGSizeMake(IMAGE_WIDTH/2,theight)
        }
        
        if width/height >= 2 {
            timageView.contentMode = UIViewContentMode.TopLeft
            var twidth = IMAGE_WIDTH
            if width < twidth {
                twidth = width
            }
            return CGSizeMake(twidth,IMAGE_WIDTH/2)
        }
        
        if width <= IMAGE_WIDTH && height <= IMAGE_WIDTH {
            timageView.contentMode = UIViewContentMode.ScaleAspectFit
            return CGSizeMake(width, height)
        }
        
        var rSize = CGSizeMake(IMAGE_WIDTH, IMAGE_WIDTH)
        if height > width {
            rSize.width = IMAGE_WIDTH/(height/width)
            rSize.height = IMAGE_WIDTH
            timageView.contentMode = UIViewContentMode.ScaleAspectFit
        } else {
            rSize.height = IMAGE_WIDTH/(width/height)
            rSize.width = IMAGE_WIDTH
            timageView.contentMode = UIViewContentMode.ScaleAspectFit
        }
        return rSize
    }
    
}
