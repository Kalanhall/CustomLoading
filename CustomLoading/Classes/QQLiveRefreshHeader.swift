//
//  QQLiveRefreshHeader.swift
//  RefreshKit_Example
//
//  Created by Logic on 2020/3/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import RefreshKit

open class QQLiveRefreshHeader : UIView, RefreshableHeader {
    
    let imageView = UIImageView()
    var oldstate: RefreshHeaderState = .idle
    var images: Array<UIImage>!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 13)
        imageView.center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
        imageView.image = UIImage(named: "loading15", in: Bundle.rk_bundleForCustomClass(QQLiveRefreshHeader.self), compatibleWith: nil)
        addSubview(imageView)
        
        let imagesNames = (0...29).map{return $0 < 10 ? "loading0\($0)" : "loading\($0)"}
        images = imagesNames.map{return UIImage(named: $0, in: Bundle.rk_bundleForCustomClass(QQLiveRefreshHeader.self), compatibleWith: nil)!}
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - RefreshableHeader
    public func heightForHeader() -> CGFloat {
        return 50.0
    }
    
    // 监听百分比变化
    public func percentUpdateDuringScrolling(_ percent:CGFloat){
        imageView.isHidden = (percent == 0)
        let adjustPercent = max(min(1.0, percent),0.0)
        let mappedIndex = Int(adjustPercent * 29)
        let imageName = mappedIndex < 10 ? "loading0\(mappedIndex)" : "loading\(mappedIndex)"
        let image = UIImage(named: imageName, in: Bundle.rk_bundleForCustomClass(QQLiveRefreshHeader.self), compatibleWith: nil)
        imageView.image = image
        
        if percent >= 1 {
            startAnimating()
        }
        // 如果是刷新结束，则过虑
        else if adjustPercent == 0 && oldstate != .refreshing {
            stopAnimating()
        }
    }
    
    // 松手即将刷新的状态
    public func didBeginRefreshingState(){
        imageView.image = nil
        startAnimating()
    }
    
    // 刷新结束，将要隐藏header
    public func didBeginHideAnimation(_ result:RefreshResult){}
    
    // 刷新结束，完全隐藏header
    public func didCompleteHideAnimation(_ result:RefreshResult){
        imageView.animationImages = nil
        imageView.stopAnimating()
        imageView.image = UIImage(named: "loading15", in: Bundle.rk_bundleForCustomClass(QQLiveRefreshHeader.self), compatibleWith: nil)
    }
    
    // 获取上一个状态
    public func stateDidChanged(_ oldState: RefreshHeaderState, newState: RefreshHeaderState) {
        oldstate = oldState
    }
    
    func startAnimating() {
        if imageView.isAnimating {
            return
        }
        imageView.animationImages = images
        imageView.animationDuration = Double(images.count) * 0.04
        imageView.startAnimating()
    }
    
    func stopAnimating() {
        oldstate = .idle
        imageView.stopAnimating()
    }
}
