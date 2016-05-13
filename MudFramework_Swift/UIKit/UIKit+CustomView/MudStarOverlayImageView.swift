//
//  MudStarOverlayImageView.swift
//  Travel
//
//  Created by TimTiger on 10/28/15.
//  Copyright © 2015 Mudmen. All rights reserved.
//

import UIKit

class MudStarOverlayImageView: UIImageView {
    override class func layerClass() -> AnyClass {
        return CAEmitterLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    var starImage: UIImage! {
        didSet {
            particle.contents = self.starImage.CGImage
        }
    }
    
    private var emitter: CAEmitterLayer {
        return layer as! CAEmitterLayer
    }
    
    private var particle: CAEmitterCell!
    
    func setup() {
        emitter.emitterMode = kCAEmitterLayerOutline
        emitter.emitterShape = kCAEmitterLayerCircle
        emitter.renderMode = kCAEmitterLayerOldestFirst
        emitter.preservesDepth = true
        
        particle = CAEmitterCell()
        
        particle.contents = UIImage.imageWithNamed("spark")!.CGImage
        particle.birthRate = 10
        
        particle.lifetime = 50
        particle.lifetimeRange = 5
        
        particle.velocity = 20
        particle.velocityRange = 10
        
        particle.scale = 0.02
        particle.scaleRange = 0.1
        particle.scaleSpeed = 0.02
        
        emitter.emitterCells = [particle]
    }
    
    var emitterTimer: NSTimer?
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if self.window != nil {
            if emitterTimer == nil {
                emitterTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "randomizeEmitterPosition", userInfo: nil, repeats: true)
            }
        } else if emitterTimer != nil {
            emitterTimer?.invalidate()
            emitterTimer = nil
        }
    }
    
    func randomizeEmitterPosition() {
        let sizeWidth = max(bounds.width, bounds.height)
        let radius = CGFloat(arc4random()) % sizeWidth
        emitter.emitterSize = CGSize(width: radius, height: radius)
        particle.birthRate = 10 + sqrt(Float(radius))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        emitter.emitterPosition = self.center
        emitter.emitterSize = self.bounds.size
    }
}
