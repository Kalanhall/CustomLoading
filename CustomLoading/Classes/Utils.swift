//
//  Utils.swift
//  CustomLoading
//
//  Created by Logic on 2020/3/26.
//

import Foundation
import UIKit

extension Bundle {
    class func rk_bundleForCustomClass(_ aClass: AnyClass) -> Bundle? {
        let bundle = Bundle(for: aClass)
        let url = URL(string: bundle.bundleIdentifier ?? "")
        let bundleURL = bundle.url(forResource: url?.pathExtension, withExtension: "bundle")
        guard let targetBundle = Bundle(url: bundleURL!) else { return nil }
        return targetBundle
    }
}
