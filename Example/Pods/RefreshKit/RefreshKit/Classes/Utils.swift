//
//  RefreshUtil.swift
//  RefreshKit
//
//  Created by Kalan on 20/3/25.
//  Copyright © 2020年 Kalan. All rights reserved.
//

import Foundation
import UIKit

struct RefreshKitConst{
    //KVO
    static let KPathOffSet = "contentOffset"
    static let KPathPanState = "state"
    static let KPathContentSize = "contentSize"
    
    //Default const
    static let defaultHeaderHeight: CGFloat = 50.0
    static let defaultFooterHeight: CGFloat = 44.0
    static let defaultLeftWidth: CGFloat    = 50.0
    static let defaultRightWidth: CGFloat   = 50.0
    
    //Tags
    static let headerTag = 100001
    static let footerTag = 100002
    static let leftTag   = 100003
    static let rightTag  = 100004
}

func RKLocalize(_ string:String)->String {
    let bundle = Bundle(for: DefaultRefreshHeader.self)
    if let url = URL(string: bundle.bundleIdentifier ?? "") {
        if let bundleURL = bundle.url(forResource: url.pathExtension, withExtension: "bundle")
        {
            let targetBundle = Bundle(url: bundleURL)
            let value = NSLocalizedString(string, tableName: "Localize", bundle: targetBundle!, value: "", comment: "")
            return value
        }
    }
    return string
}

struct RefreshKitHeaderString{
    static let pullDownToRefresh = RKLocalize("pullDownToRefresh")
    static let releaseToRefresh = RKLocalize("releaseToRefresh")
    static let refreshSuccess = RKLocalize("refreshSuccess")
    static let refreshFailure = RKLocalize("refreshFailure")
    static let refreshing = RKLocalize("refreshing")
}

struct RefreshKitFooterString{
    static let pullUpToRefresh = RKLocalize("pullUpToRefresh")
    static let refreshing = RKLocalize("refreshing")
    static let noMoreData = RKLocalize("noMoreData")
    static let tapToRefresh = RKLocalize("tapToRefresh")
    static let scrollAndTapToRefresh = RKLocalize("scrollAndTapToRefresh")
}

struct RefreshKitLeftString{
    static let scrollToClose = "滑动结束浏览"
    static let releaseToClose = "松开结束浏览"
}

struct RefreshKitRightString{
    static let scrollToViewMore = "滑动浏览更多"
    static let releaseToViewMore = "滑动浏览更多"
}

extension UIImage {
    
    class func rk_image(named imageName: String, in bundle: Bundle?) -> UIImage? {
        if let url = URL(string: bundle?.bundleIdentifier ?? "")
        {
            if let bundleURL = bundle?.url(forResource: url.pathExtension, withExtension: "bundle")
            {
                let imageBundle = Bundle(url: bundleURL)
                return UIImage(named: imageName, in: imageBundle, compatibleWith: nil)
            }
        }
        return nil
    }
    
}
