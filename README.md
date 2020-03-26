# CustomLoading

[![CI Status](https://img.shields.io/travis/Kalanhall@163.com/CustomLoading.svg?style=flat)](https://travis-ci.org/Kalanhall@163.com/CustomLoading)
[![Version](https://img.shields.io/cocoapods/v/CustomLoading.svg?style=flat)](https://cocoapods.org/pods/CustomLoading)
[![License](https://img.shields.io/cocoapods/l/CustomLoading.svg?style=flat)](https://cocoapods.org/pods/CustomLoading)
[![Platform](https://img.shields.io/cocoapods/p/CustomLoading.svg?style=flat)](https://cocoapods.org/pods/CustomLoading)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```ruby
// 初始化方式
// 腾讯视频
let header = QQLiveRefreshHeader(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: 50))
    self.tableView.handleRefreshHeader(with: header,container:self) { [weak self] in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        }
};

// 京东购物车
let header = JDPullRefreshHeader(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: 60))
    self.tableView.handleRefreshHeader(with: header,container:self) { [weak self] in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        }
};

// 时钟
let header = ClockRefreshHeader(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: 50))
    self.tableView.handleRefreshHeader(with: header,container:self) { [weak self] in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        }
};

self.tableView.switchRefreshHeader(to: .refreshing)

```

## Requirements

## Installation

CustomLoading is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CustomLoading'
```

## Author

Kalanhall@163.com, Kalan

## License

CustomLoading is available under the MIT license. See the LICENSE file for more info.
