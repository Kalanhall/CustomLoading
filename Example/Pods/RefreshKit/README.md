# RefreshKit

[![CI Status](https://img.shields.io/travis/Kalanhall@163.com/RefreshKit.svg?style=flat)](https://travis-ci.org/Kalanhall@163.com/RefreshKit)
[![Version](https://img.shields.io/cocoapods/v/RefreshKit.svg?style=flat)](https://cocoapods.org/pods/RefreshKit)
[![License](https://img.shields.io/cocoapods/l/RefreshKit.svg?style=flat)](https://cocoapods.org/pods/RefreshKit)
[![Platform](https://img.shields.io/cocoapods/p/RefreshKit.svg?style=flat)](https://cocoapods.org/pods/RefreshKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```ruby
// 自定义动画刷新
class CustomRefreshHeader : UIView, RefreshableHeader{
    
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(x: 0, y: 0, width: 27, height: 10)
        imageView.center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
        imageView.image = UIImage(named: "loading15")
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - RefreshableHeader
    func heightForHeader() -> CGFloat {
        return 50.0
    }
    
    //监听百分比变化
    func percentUpdateDuringScrolling(_ percent:CGFloat){
        imageView.isHidden = (percent == 0)
        let adjustPercent = max(min(1.0, percent),0.0)
        let scale = 0.2 + (1.0 - 0.2) * adjustPercent;
        imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        let mappedIndex = Int(adjustPercent * 15)
        let imageName = mappedIndex < 10 ? "loading0\(mappedIndex)" : "loading\(mappedIndex)"
        let image = UIImage(named: imageName)
        imageView.image = image
    }
    
    // 松手即将刷新的状态
    func didBeginRefreshingState(){
        imageView.image = nil
        let images = (0...29).map{return $0 < 10 ? "loading0\($0)" : "loading\($0)"}
        imageView.animationImages = images.map{return UIImage(named:$0)!}
        imageView.animationDuration = Double(images.count) * 0.04
        imageView.startAnimating()
    }
    
    // 刷新结束，将要隐藏header
    func didBeginHideAnimation(_ result:RefreshResult){}
    
    // 刷新结束，完全隐藏header
    func didCompleteHideAnimation(_ result:RefreshResult){
        imageView.animationImages = nil
        imageView.stopAnimating()
        imageView.image = UIImage(named: "loading15")
    }
}

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    // 使用方式
    // 默认
    let header = DefaultRefreshHeader.header()
    header.imageView.isHidden = true
    header.indicator.alpha = 0
    header.tintColor = .red
    header.textLabel.font = UIFont.systemFont(ofSize: 12)
    header.imageRenderingWithTintColor = true

    self.tableView.handleRefreshHeader(with: header, container: self) { [weak self] in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self?.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
        }
    }

    self.tableView.handleRefreshFooter(container:self) { [weak self] in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self?.tableView.switchRefreshFooter(to: .normal)
        }
    };

    // 自定义
    let header = CustomRefreshHeader(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: 50))
        self.tableView.handleRefreshHeader(with: header,container:self) { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
            }
    };

    self.tableView.switchRefreshHeader(to: .refreshing)
```

## Requirements

## Installation

RefreshKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RefreshKit'
```

## Author

Kalanhall@163.com, Kalan

## License

RefreshKit is available under the MIT license. See the LICENSE file for more info.
