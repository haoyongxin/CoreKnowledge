//
//  ConcurrentDispatchQueueViewController.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/3/13.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class ConcurrentDispatchQueueViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//    self.navigationController?.setNavigationBarHidden(true, animated: true)
//  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    _ = self.navigationController?.popViewController(animated: true)
  }
  
}
