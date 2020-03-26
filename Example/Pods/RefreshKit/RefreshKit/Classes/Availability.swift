//
//  Availability.swift
//  RefreshKit
//
//  Created by Kalan on 2017/11/9.
//  Copyright © 2020年 Kalan . All rights reserved.
//

import Foundation
import UIKit

public protocol SetUp {}
public extension SetUp where Self: AnyObject {
    @discardableResult
    @available(*, deprecated, message: "This method will be removed at V 1.0.0")
    func SetUp(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: SetUp {}


// Header
public extension UIScrollView{
    
    @discardableResult
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func setUpHeaderRefresh(_ action:@escaping ()->())->DefaultRefreshHeader{
        let header = DefaultRefreshHeader(frame:CGRect(x: 0,
                                                       y: 0,
                                                       width: self.frame.width,
                                                       height: RefreshKitConst.defaultHeaderHeight))
        return setUpHeaderRefresh(header, action: action)
    }
    @discardableResult
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func setUpHeaderRefresh<T:UIView>(_ header:T,action:@escaping ()->())->T where T:RefreshableHeader{
        let oldContain = self.viewWithTag(RefreshKitConst.headerTag)
        oldContain?.removeFromSuperview()
        let containFrame = CGRect(x: 0, y: -self.frame.height, width: self.frame.width, height: self.frame.height)
        let containComponent = RefreshHeaderContainer(frame: containFrame)
        if let endDuration = header.durationOfHideAnimation?(){
            containComponent.durationOfEndRefreshing = endDuration
        }
        containComponent.tag = RefreshKitConst.headerTag
        containComponent.refreshAction = action
        self.addSubview(containComponent)
        
        containComponent.delegate = header
        header.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        let bounds = CGRect(x: 0,y: containFrame.height - header.frame.height,width: self.frame.width,height: header.frame.height)
        header.frame = bounds
        containComponent.addSubview(header)
        return header
    }
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func beginHeaderRefreshing(){
        let header = self.viewWithTag(RefreshKitConst.headerTag) as? RefreshHeaderContainer
        header?.beginRefreshing()
    }
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func endHeaderRefreshing(_ result:RefreshResult = .none,delay:Double = 0.0){
        let header = self.viewWithTag(RefreshKitConst.headerTag) as? RefreshHeaderContainer
        header?.endRefreshing(result,delay: delay)
    }
}

// Footer
public extension UIScrollView{
    @discardableResult
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func setUpFooterRefresh(_ action:@escaping ()->())->DefaultRefreshFooter{
        let footer = DefaultRefreshFooter(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: self.frame.width,
                                                        height: RefreshKitConst.defaultFooterHeight))
        return setUpFooterRefresh(footer, action: action)
    }
    @discardableResult
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func setUpFooterRefresh<T:UIView>(_ footer:T,action:@escaping ()->())->T where T:RefreshableFooter{
        let oldContain = self.viewWithTag(RefreshKitConst.footerTag)
        oldContain?.removeFromSuperview()
        let frame = CGRect(x: 0,y: 0,width: self.frame.width, height: RefreshKitConst.defaultFooterHeight)
        
        let containComponent = RefreshFooterContainer(frame: frame)
        containComponent.tag = RefreshKitConst.footerTag
        containComponent.refreshAction = action
        self.insertSubview(containComponent, at: 0)
        
        containComponent.delegate = footer
        footer.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        footer.frame = containComponent.bounds
        containComponent.addSubview(footer)
        return footer
    }
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func beginFooterRefreshing(){
        let footer = self.viewWithTag(RefreshKitConst.footerTag) as? RefreshFooterContainer
        if footer?.state == .idle {
            footer?.beginRefreshing()
        }
    }
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func endFooterRefreshing(){
        let footer = self.viewWithTag(RefreshKitConst.footerTag) as? RefreshFooterContainer
        footer?.endRefreshing()
    }
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func setFooterNoMoreData(){
        let footer = self.viewWithTag(RefreshKitConst.footerTag) as? RefreshFooterContainer
        footer?.endRefreshing()
    }
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func resetFooterToDefault(){
        let footer = self.viewWithTag(RefreshKitConst.footerTag) as? RefreshFooterContainer
        footer?.resetToDefault()
    }
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    func endFooterRefreshingWithNoMoreData(){
        let footer = self.viewWithTag(RefreshKitConst.footerTag) as? RefreshFooterContainer
        footer?.endRefreshing()
        footer?.updateToNoMoreData()
    }
}

//Left
extension UIScrollView{
    @discardableResult
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    public func setUpLeftRefresh(_ action: @escaping ()->())->DefaultRefreshLeft{
        let left = DefaultRefreshLeft(frame: CGRect(x: 0,y: 0,width: RefreshKitConst.defaultLeftWidth, height: self.frame.height))
        return setUpLeftRefresh(left, action: action)
    }
    @discardableResult
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    public func setUpLeftRefresh<T:UIView>(_ left:T,action:@escaping ()->())->T where T:RefreshableLeftRight{
        let oldContain = self.viewWithTag(RefreshKitConst.leftTag)
        oldContain?.removeFromSuperview()
        let frame = CGRect(x: -1.0 * RefreshKitConst.defaultLeftWidth,y: 0,width: RefreshKitConst.defaultLeftWidth, height: self.frame.height)
        let containComponent = RefreshLeftContainer(frame: frame)
        containComponent.tag = RefreshKitConst.leftTag
        containComponent.refreshAction = action
        self.insertSubview(containComponent, at: 0)
        
        containComponent.delegate = left
        left.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        left.frame = containComponent.bounds
        containComponent.addSubview(left)
        return left
    }
}

//Right
extension UIScrollView{
    @discardableResult
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    public  func setUpRightRefresh(_ action:@escaping ()->())->DefaultRefreshRight{
        let right = DefaultRefreshRight(frame: CGRect(x: 0 ,y: 0 ,width: RefreshKitConst.defaultLeftWidth ,height: self.frame.height ))
        return setUpRightRefresh(right, action: action)
    }
    @discardableResult
    @available(*, deprecated, message: "Use new API at PullToRefresh.Swift")
    public func setUpRightRefresh<T:UIView>(_ right:T,action:@escaping ()->())->T where T:RefreshableLeftRight{
        let oldContain = self.viewWithTag(RefreshKitConst.rightTag)
        oldContain?.removeFromSuperview()
        let frame = CGRect(x: 0 ,y: 0 ,width: RefreshKitConst.defaultLeftWidth ,height: self.frame.height )
        let containComponent = RefreshRightContainer(frame: frame)
        containComponent.tag = RefreshKitConst.rightTag
        containComponent.refreshAction = action
        self.insertSubview(containComponent, at: 0)
        
        containComponent.delegate = right
        right.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        right.frame = containComponent.bounds
        containComponent.addSubview(right)
        return right
    }
}

