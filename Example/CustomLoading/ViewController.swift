//
//  ViewController.swift
//  CustomLoading
//
//  Created by Kalanhall@163.com on 03/26/2020.
//  Copyright (c) 2020 Kalanhall@163.com. All rights reserved.
//

import UIKit
import CustomLoading

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let header = QQLiveRefreshHeader(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: 50))
//            self.tableView.handleRefreshHeader(with: header,container:self) { [weak self] in
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//                    self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
//                }
//        };
        
        let header = JDPullRefreshHeader(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: 60))
            self.tableView.handleRefreshHeader(with: header,container:self) { [weak self] in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
                }
        };
        
//        let header = ClockRefreshHeader(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: 50))
//            self.tableView.handleRefreshHeader(with: header,container:self) { [weak self] in
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//                    self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
//                }
//        };

        self.tableView.switchRefreshHeader(to: .refreshing)
    }

}

