//
//  Right.swift
//  RefreshKit
//
//  Created by Kalan on 20/3/25.
//  Copyright © 2020年 Kalan. All rights reserved.
//
import Foundation
import UIKit


open class DefaultRefreshRight:UIView, RefreshableLeftRight {
    public static func right()->DefaultRefreshRight{
        return DefaultRefreshRight(frame: CGRect(x: 0, y: 0, width: RefreshKitConst.defaultRightWidth, height: UIScreen.main.bounds.size.height))
    }
    
    public var refreshWidth: CGFloat = RefreshKitConst.defaultRightWidth
    public let imageView:UIImageView = UIImageView()
    public let textLabel:UILabel  = UILabel()
    fileprivate var textDic = [RefreshKitLeftRightText:String]()
    
    /**
     You can only call this function before pull
     */
    open func setText(_ text:String,mode:RefreshKitLeftRightText){
        textDic[mode] = text
        textLabel.text = textDic[.scrollToAction]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(textLabel)
        textLabel.autoresizingMask = .flexibleHeight
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 14)
        imageView.frame = CGRect(x: 0, y: 0,width: 20, height: 20)
        let image = UIImage.rk_image(named: "arrow_left", in: Bundle(for: DefaultRefreshHeader.self))
        imageView.image = image
        textDic[.scrollToAction] = RefreshKitRightString.scrollToViewMore
        textDic[.releaseToAction] = RefreshKitRightString.releaseToViewMore
        textLabel.text = textDic[.scrollToAction]
    }
    
    public  required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = CGRect(x: 30,y: 0,width: 20,height: frame.size.height)
        imageView.center = CGPoint(x: 10,y: frame.size.height/2)
    }
    
    // MARK: - RefreshableLeftRight Protocol  -
    open func widthForComponent() -> CGFloat {
        return refreshWidth
    }
    
    open func percentUpdateDuringScrolling(_ percent:CGFloat){
        if percent > 1.0{
            guard self.imageView.transform == CGAffineTransform.identity else{
                return
            }
            UIView.animate(withDuration: 0.4, animations: {
                self.imageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi+0.000001)
            })
            textLabel.text = textDic[.releaseToAction]
        }
        if percent <= 1.0{
            guard self.imageView.transform == CGAffineTransform(rotationAngle: -CGFloat.pi+0.000001) else{
                return
            }
            textLabel.text = textDic[.scrollToAction]
            UIView.animate(withDuration: 0.4, animations: {
                self.imageView.transform = CGAffineTransform.identity
            })
        }
    }
    
    open func didCompleteHideAnimation() {
        imageView.transform = CGAffineTransform.identity
        textLabel.text = textDic[.scrollToAction]
    }
    
    open  func didBeginRefreshing() {
        
    }
    
    override open var tintColor: UIColor!{
        didSet{
            imageView.tintColor = tintColor
            textLabel.textColor = tintColor
        }
    }
}

class RefreshRightContainer:UIView{
    // MARK: - Propertys -
    enum RefreshHeaderState {
        case idle
        case pulling
        case refreshing
        case willRefresh
    }
    var refreshAction:(()->())?
    var attachedScrollView:UIScrollView!
    weak var delegate:RefreshableLeftRight?
    fileprivate var _state:RefreshHeaderState = .idle
    var state:RefreshHeaderState{
        get{
            return _state
        }
        set{
            guard newValue != _state else{
                return
            }
            _state =  newValue
            switch newValue {
            case .refreshing:
                DispatchQueue.main.async(execute: {
                    self.delegate?.didBeginRefreshing()
                    self.refreshAction?()
                    self.endRefreshing()
                    self.delegate?.didCompleteHideAnimation()
                })
            default:
                break
            }
        }
    }
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit(){
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = .flexibleWidth
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life circle -
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if self.state == .willRefresh {
            self.state = .refreshing
        }
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard newSuperview is UIScrollView else{
            return;
        }
        attachedScrollView = newSuperview as? UIScrollView
        addObservers()
        self.frame = CGRect(x: attachedScrollView.contentSize.width,y: 0,width: self.frame.width, height: self.frame.height)
    }
    deinit{
        removeObservers()
    }
    // MARK: - Private -
    fileprivate func addObservers(){
        attachedScrollView?.addObserver(self, forKeyPath:RefreshKitConst.KPathOffSet, options: [.old,.new], context: nil)
        attachedScrollView?.addObserver(self, forKeyPath:RefreshKitConst.KPathContentSize, options:[.old,.new] , context: nil)
    }
    fileprivate func removeObservers(){
        attachedScrollView?.removeObserver(self, forKeyPath: RefreshKitConst.KPathOffSet,context: nil)
        attachedScrollView?.removeObserver(self, forKeyPath: RefreshKitConst.KPathContentSize,context: nil)
    }

    func handleScrollOffSetChange(_ change: [NSKeyValueChangeKey : Any]?){
        if state == .refreshing {
            return;
        }
        let offSetX = attachedScrollView.contentOffset.x
        let contentWidth = attachedScrollView.contentSize.width
        let contentInset = attachedScrollView.contentInset
        let scrollViewWidth = attachedScrollView.bounds.width
        if attachedScrollView.isDragging {
            let percent = (offSetX + scrollViewWidth - contentInset.left - contentWidth)/self.frame.width
            self.delegate?.percentUpdateDuringScrolling(percent)
            if state == .idle && percent > 1.0 {
                self.state = .pulling
            }else if state == .pulling && percent <= 1.0{
                state = .idle
            }
        }else if state == .pulling{
            beginRefreshing()
        }
    }
    func handleContentSizeChange(_ change: [NSKeyValueChangeKey : Any]?){
        self.frame = CGRect(x: self.attachedScrollView.contentSize.width,y: 0,width: self.frame.size.width,height: self.frame.size.height)
    }
    
    // MARK: - KVO -
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard self.isUserInteractionEnabled else{
            return;
        }
        if keyPath == RefreshKitConst.KPathOffSet {
            handleScrollOffSetChange(change)
        }
        guard !self.isHidden else{
            return;
        }
        if keyPath == RefreshKitConst.KPathContentSize {
            handleContentSizeChange(change)
        }
    }
    // MARK: - API -
    func beginRefreshing(){
        if self.window != nil {
            self.state = .refreshing
        }else{
            if state != .refreshing{
                self.state = .willRefresh
            }
        }
    }
    func endRefreshing(){
        self.state = .idle
    }
    
    
}
