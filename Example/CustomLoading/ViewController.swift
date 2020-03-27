//
//  ViewController.swift
//  CustomLoading
//
//  Created by Kalanhall@163.com on 03/26/2020.
//  Copyright (c) 2020 Kalanhall@163.com. All rights reserved.
//

import UIKit
import CustomLoading

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .always
        } else {
            self.automaticallyAdjustsScrollViewInsets = true
        }
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description())

        return cell!
    }

}

