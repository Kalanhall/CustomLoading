//
//  ClockRefreshHeader.swift
//  CustomLoading
//
//  Created by Logic on 2020/3/26.
//

import UIKit
import RefreshKit
import Lottie

open class ClockRefreshHeader: UIView, RefreshableHeader {

    var isPlaying: Bool = false
    
    lazy var imageView = { () -> AnimationView in
        let view = AnimationView(name: "clock", bundle: Bundle.rk_bundleForCustomClass(JDPullRefreshHeader.self)!, imageProvider: nil, animationCache: nil)
        return view
    } ()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30  )
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
        imageView.isHidden = (percent == 0)
        let adjustPercent = max(min(1.0, percent), 0.0)
        
        if !isPlaying {
            imageView.loopMode = .playOnce
            imageView.play(toProgress: adjustPercent)
        }
        
        if adjustPercent >= 1.0 {
            startAnimating()
        } else if adjustPercent == 0 {
            stopAnimating()
        }
    }
    
    // 松手即将刷新的状态
    public func didBeginRefreshingState(){
        startAnimating()
    }
    
    // 刷新结束，将要隐藏header
    public func didBeginHideAnimation(_ result:RefreshResult){}
    
    // 刷新结束，完全隐藏header
    public func didCompleteHideAnimation(_ result:RefreshResult){
        stopAnimating()
    }
    
    func startAnimating() {
        if isPlaying == false {
            isPlaying = true
            imageView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
        }
    }
    
    func stopAnimating() {
        isPlaying = false
        imageView.stop()
    }


}
