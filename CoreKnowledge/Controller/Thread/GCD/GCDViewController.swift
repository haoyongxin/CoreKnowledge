//
//  GCDViewController.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/3/13.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class GCDViewController: UIViewController {
  
  var gcdArray: Array<String>!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    self.backItem()
    gcdArray = ["GCD-Serial","GCD-Concurrent"]
    self.installButtons()
    if let gesture = self.navigationController?.interactivePopGestureRecognizer {
      print("gesture:",gesture.isEnabled)
    }
  }
  
  func backItem() {
    let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 44))
    backButton.setTitle("返回", for: .normal)
    backButton.setTitleColor(UIColor.red, for: .normal)
    backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
  }
  
  @objc func backAction() {
    _ = self.navigationController?.popViewController(animated: true)
  }
  
  func installButtons() {
    let width = self.view.bounds.width / 2
    let height = CGFloat(100)
    for i in 0..<gcdArray.count {
      let col = CGFloat(i % 2)
      let row = CGFloat(i / 2)
      let button = CustomThreadButton.init(frame: CGRect(x: col * width, y: row * width + 70, width: width, height: height))
      button.setup(title: gcdArray[i], titleColor: UIColor.black, tag: i, clickAction: { [unowned self] (tag) in
        self.buttonClick(tag: tag)
      })
      self.view.addSubview(button)
    }
  }
  
  func buttonClick(tag: Int) {
    let viewController: UIViewController!
    switch tag {
    case 0:
      viewController = SerialDispatchQueueViewController()
    case 1:
      viewController = ConcurrentDispatchQueueViewController()
    default:
      viewController = SerialDispatchQueueViewController()
      break
    }
    viewController.title = gcdArray[tag]
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
