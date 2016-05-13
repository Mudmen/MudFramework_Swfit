////
////  MudImageBrowserViewController.swift
////  Travel
////
////  Created by TimTiger on 6/18/15.
////  Copyright (c) 2015 Mudmen. All rights reserved.
////
//
//import UIKit
//import QuartzCore
//
//private let shareInstance = MudImageBrowserViewController()
//
//class MudImageBrowserViewController: NSObject,UIScrollViewDelegate,MudActionSheetDelegate {
//    var containerView: UIView?
//    var scrollView: UIScrollView?
//    var imageView: UIImageView?
//    private var imageRect: CGRect?
//    private var imageRadius: CGFloat = 0
//    
//    //share instance
//    class var shareController: MudImageBrowserViewController {
//        return shareInstance
//    }
//    
//    override init() {
//        super.init()
//    }
//    
//    //MARK: - public API
//    /// show image
//    class func browerImageWithUrl(imageString: String?,image: UIImage?) {
//        MudImageBrowserViewController.browerImageWithUrl(imageString, image: image, defaultImage: nil, animationStartFrame: CGRectZero, radius: 0)
//    }
//    
//    /// show image
//    class func browerImageWithUrl(imageString: String?,image: UIImage?,defaultImage: UIImage?,animationStartFrame: CGRect,radius: CGFloat) {
//        
//        //图片地址和图片都为空 直接不显示
//        if String.isEmptyString(imageString) && image == nil {
//            return
//        }
//        
//        //图片地址为空， 图片不为空 直接显示图片
//       else if String.isEmptyString(imageString) && image != nil {
//            MudImageBrowserViewController.shareController.showImageWithImageURL(nil, placeholderImage: image, frame: animationStartFrame, radius: radius)
//        }
//        
//        //图片地址不为空，图片为空
//       else if String.isNotEmptyString(imageString) && image == nil {
//            //直接将图片地址作为名称读取图片
//            var timage = UIImage(named: imageString!)
//            if timage != nil {
//                //如果存在显示此图片
//                MudImageBrowserViewController.shareController.showImageWithImageURL(NSURL(string: imageString!), placeholderImage: timage, frame: animationStartFrame, radius: radius)
//            } else {
//                //直接到缓存中寻找对应的图片
//                timage = SDImageCache.sharedImageCache().imageFromDiskCacheForKey(imageString)
//                if timage != nil {
//                    //如果图片存在世界显示此图片
//                    MudImageBrowserViewController.shareController.showImageWithImageURL(NSURL(string: imageString!), placeholderImage: timage, frame: animationStartFrame, radius: radius)
//                } else {
//                    //去下载图片
//                    MudImageBrowserViewController.shareController.showloadingImageWithImageURL(NSURL(string: imageString!), placeholderImage: defaultImage, frame: animationStartFrame, radius: radius)
//                }
//            }
//        }
//        //图片地址不为空，图片不为空
//        else {
//            MudImageBrowserViewController.shareController.showImageWithImageURL(NSURL(string: imageString!), placeholderImage: defaultImage, frame: animationStartFrame, radius: radius)
//        }
//    }
//    
//    private func showloadingImageWithImageURL(url: NSURL?,placeholderImage: UIImage?,frame: CGRect,radius: CGFloat) {
//        //设置好视图
//        self.setView(frame, radius: radius)
//        //显示正在loading
//        MBProgressHUD.showHUDAddedTo(MudImageBrowserViewController.shareController.containerView!, text: "", animated: true)
//        //下载图片
//        self.imageView?.sd_setImageWithURL(url, placeholderImage: placeholderImage, completed: { (image, error, type, url) -> Void in
//            if error == nil {
//                //加载图片
//                self.imageView?.image = image
//                self.refreshImageView()
//            }
//            MBProgressHUD.hideAllHUDsForView(self.containerView, animated: true)
//        })
//        self.showWithRect(frame, radius: radius)
//    }
//    
//    private func showImageWithImageURL(url: NSURL?,placeholderImage: UIImage?,frame: CGRect,radius: CGFloat) {
//        self.setView(frame, radius: radius)
//        //下载图片
//        self.imageView?.sd_setImageWithURL(url, placeholderImage: placeholderImage, completed: { (image, error, type, url) -> Void in
//            if image != nil {
//                //加载图片
//                self.imageView?.image = image
//            }
//            self.refreshImageView()
//        })
//        self.showWithRect(frame, radius: radius)
//    }
//    
//    private func setView(frame: CGRect,radius: CGFloat) {
//            self.containerView = UIView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height))
//            self.containerView?.backgroundColor = UIColor.clearColor()
//            self.scrollView = UIScrollView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height))
//            self.scrollView?.backgroundColor = UIColor.clearColor()
//            self.scrollView?.bounces = false
//            self.scrollView?.bouncesZoom = true
//            self.scrollView?.delegate = self
//            self.imageView = UIImageView(frame: self.scrollView!.bounds)
//            self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//            self.imageView?.backgroundColor = UIColor.clearColor()
//            self.scrollView?.addSubview(self.imageView!)
//            self.containerView?.addSubview(self.scrollView!)
//            
//            let tapgesture = UITapGestureRecognizer()
//            tapgesture.addTarget(self, action: "tapAction:")
//            tapgesture.numberOfTapsRequired = 1
//            self.containerView?.addGestureRecognizer(tapgesture)
//            
//            let longPressGesture = UILongPressGestureRecognizer()
//            longPressGesture.addTarget(self, action: "longPressAction:")
//            self.imageView?.userInteractionEnabled = true
//            self.imageView?.addGestureRecognizer(longPressGesture)
//        
//            self.imageRect = frame
//            self.imageRadius = radius
//    }
//    
//    private func refreshImageView() {
//        let frame = self.getImageFrame()
//        self.imageView?.frame = frame
//        self.scrollView?.contentSize = CGSizeMake(0, frame.height)
//        self.scrollView?.maximumZoomScale = 10
//        self.scrollView?.minimumZoomScale = 1.0
//    }
//    
//    //get image frame
//   private func getImageFrame()->CGRect {
//        var frame = self.scrollView!.bounds
//        if self.imageView?.image != nil {
//            let image = self.imageView!.image!
//            let width = image.size.width
//            let height = image.size.height
//            if width <= SCREENWIDTH && height <= SCREENHEIGHT {
//                frame.size.width = SCREENWIDTH
//                frame.size.height = SCREENHEIGHT
//                self.imageView?.contentMode = UIViewContentMode.Center
//            } else if width/height >= SCREENWIDTH/SCREENHEIGHT {
//                frame.size.width = SCREENWIDTH
//                frame.size.height = SCREENHEIGHT//((SCREENWIDTH*image.size.height)/image.size.width)
//                self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//            } else if width/height < SCREENWIDTH/SCREENHEIGHT {
//                frame.size.height =  ((SCREENWIDTH*image.size.height)/image.size.width)
//                frame.size.width = SCREENWIDTH
//                self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//            }
//        }
//        return frame
//    }
//    
//    private func imageDismissFrame()->CGRect {
//        var frame = self.scrollView!.bounds
//        if self.imageView?.image != nil {
//            let image = self.imageView!.image!
//            let width = image.size.width
//            let height = image.size.height
//            if width <= SCREENWIDTH && height <= SCREENHEIGHT {
//                frame.size.width = width
//                frame.size.height = height
//                frame.origin.x = (SCREENWIDTH-width)/2
//                frame.origin.y = (SCREENHEIGHT-height)/2
//            } else if width/height > SCREENWIDTH/SCREENHEIGHT {
//                frame.size.width = SCREENWIDTH
//                frame.size.height = ((SCREENWIDTH*image.size.height)/image.size.width)
//                frame.origin.y = (SCREENHEIGHT-frame.size.height)/2
//            } else if width/height < SCREENWIDTH/SCREENHEIGHT {
//                frame.size.height =  ((SCREENWIDTH*image.size.height)/image.size.width)
//                frame.size.width = SCREENWIDTH
//            }
//        }
//        return frame
//    }
//    
//    private func showWithRect(rect: CGRect,radius: CGFloat) {
//        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
//        if rect == CGRectZero  {
//            self.scrollView?.backgroundColor = UIColor.blackColor()
//            let keywindow = UIApplication.sharedApplication().keyWindow
//            keywindow?.addSubview(self.containerView!)
//        } else {
//            self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//            self.scrollView?.backgroundColor = UIColor.blackColor()
//            let keywindow = UIApplication.sharedApplication().keyWindow
//            keywindow?.addSubview(self.containerView!)
//            self.imageView?.layer.masksToBounds = true
//            self.imageView?.layer.cornerRadius = radius
//            self.imageView?.frame = rect
//            let frame = self.getImageFrame()
//            self.scrollView?.contentSize = CGSizeMake(0, frame.height)
//            UIView.animateWithDuration(0.35, animations: { () -> Void in
//                self.imageView?.frame = frame
//                self.imageView?.layer.cornerRadius = 0
//                }, completion: { (finished) -> Void in
//                    
//            })
//        }
//    }
//    
//    func tapAction(sender: UITapGestureRecognizer) {
//        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.None)
//        MBProgressHUD.hideAllHUDsForView(self.containerView, animated: true)
//        self.scrollView?.backgroundColor = UIColor.clearColor()
//        self.scrollView?.setZoomScale(1, animated: false)
//        self.scrollView?.contentOffset = CGPointMake(0, 0)
//        self.imageView?.frame = self.imageDismissFrame()
//        if self.imageRect != nil && self.imageRect != CGRectZero && self.imageView?.image != nil {
//            self.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
//            UIView.animateWithDuration(0.25, animations: { () -> Void in
//                self.imageView?.frame = self.imageRect!
//                self.imageView?.layer.cornerRadius = self.imageRadius
//                }, completion: { (finished) -> Void in
//                    self.imageRect = nil
//                    self.imageRadius = 0
//                    self.containerView?.removeFromSuperview()
//            })
//        } else {
//            self.imageRect = nil
//            self.imageRadius = 0
//            self.containerView?.removeFromSuperview()
//        }
//    }
//    
//    func longPressAction(sender: UILongPressGestureRecognizer) {
//        if sender.state == UIGestureRecognizerState.Began && self.imageView?.image != nil {
//            let actionSheet = MudActionSheet(title: nil, adelegate: self, destructiveButtonIndex: -1, buttonTitles: [MudLocalString.stringForKey("SaveToPhone", tableName: "MudLocalization")])
//            actionSheet.show()
//        }
//    }
//    
//    func actionSheet(actionSheet: MudActionSheet, didSelectedButtonAtIndex buttonIndex: Int) {
//        if buttonIndex == 1 {
//            UIImageWriteToSavedPhotosAlbum(self.imageView!.image!, self, "saveImageComplete:err:context:", nil)
//        }
//    }
//    
//    func saveImageComplete(image: UIImage,err: NSError?,context:UnsafePointer<()>)
//    {
//        if err == nil {
//            SVProgressHUD.showSuccessWithStatus(MudLocalString.stringForKey("SaveSuccess", tableName: "MudLocalization"))
//        }
//    }
//    
//    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        return scrollView.subviews[0]
//    }
//    
//    func scrollViewDidZoom(scrollView: UIScrollView) {
//        if scrollView.zoomScale <= 1 {
//            if self.imageView?.frame.size.height > 2*SCREENHEIGHT {
//                self.imageView?.center = CGPointMake(self.scrollView!.center.x, self.imageView!.center.y)
//            } else {
//                self.imageView?.center = self.scrollView!.center
//            }
//        }
//    }
//    
//    deinit {
//        
//    }
//    
//    
//}
