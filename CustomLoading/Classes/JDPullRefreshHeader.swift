//
//  JDPullRefreshHeader.swift
//  CustomLoading_Example
//
//  Created by Logic on 2020/3/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RefreshKit
import Lottie

open class JDPullRefreshHeader: UIView, RefreshableHeader {
    
    var playing: Bool = false
    var oldstate: RefreshHeaderState = .idle
    
    lazy var imageView = { () -> AnimationView in
        let view = AnimationView(name: "loading", bundle: Bundle.rk_bundleForCustomClass(JDPullRefreshHeader.self)!, imageProvider: nil, animationCache: nil)
        return view
    } ()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        imageView.center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - RefreshableHeader -
    public func heightForHeader() -> CGFloat {
        return self.bounds.size.height
    }
    
    // 监听百分比变化
    public func percentUpdateDuringScrolling(_ percent:CGFloat){
        let adjustPercent = max(min(1.0, percent), 0.0)
        if adjustPercent >= 0.75 && playing == false {
            imageView.play(fromProgress: 0, toProgress: 1, loopMode: .playOnce) { [weak self] (finish) in
                if finish {
                    self?.startAnimating()
                }
            }
        }
        
        // 如果是刷新结束，则过虑
        if adjustPercent == 0 && oldstate != .refreshing {
            stopAnimating()
        }
    }
    
    // 松手即将刷新的状态
    public func didBeginRefreshingState() {
        startAnimating()
    }
    
    // 刷新结束，将要隐藏header
    public func didBeginHideAnimation(_ result:RefreshResult) {}
    
    // 刷新结束，完全隐藏header
    public func didCompleteHideAnimation(_ result:RefreshResult) {
        stopAnimating()
    }
    
    // 获取上一个状态
    public func stateDidChanged(_ oldState: RefreshHeaderState, newState: RefreshHeaderState) {
        oldstate = oldState
    }
    
    func startAnimating() {
        if playing == false {
            playing = true
            imageView.play(fromProgress: 0.25, toProgress: 1, loopMode: .loop, completion: nil)
        }
    }
    
    func stopAnimating() {
        playing = false
        oldstate = .idle
        imageView.stop()
    }

}
