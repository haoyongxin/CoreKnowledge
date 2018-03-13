//
//  KCThreadMainViewController.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/3/8.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class KCThreadMainViewController: UIViewController {
  var threadArray: Array<String>!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    threadArray = ["GCD","OperationQueue"]
    self.installButtons()
  }
  
  func installButtons() {
    let width = self.view.bounds.width / 2
    let height = CGFloat(100)
    for i in 0..<threadArray.count {
      let col = CGFloat(i % 2)
      let row = CGFloat(i / 2)
      let button = CustomThreadButton.init(frame: CGRect(x: col * width, y: row * width + 70, width: width, height: height))
      button.setup(title: threadArray[i], titleColor: UIColor.black, tag: i, clickAction: { [unowned self] (tag) in
        self.buttonClick(tag: tag)
      })
      self.view.addSubview(button)
    }
  }
  
  func buttonClick(tag: Int) {
    let viewController: UIViewController!
    switch tag {
    case 0:
      viewController = GCDViewController()
    case 1:
      viewController = OperationQueueViewController()
    default:
      viewController = GCDViewController()
      break
    }
    viewController.title = threadArray[tag]
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

class CustomThreadButton: UIButton {
  var clickAction: ((Int) -> Void)!
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.white
    self.layer.borderWidth = 0.5
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.masksToBounds = true
  }
  
  func setup(title: String, titleColor: UIColor,tag: Int, clickAction:@escaping (Int) -> Void) {
    self.setTitle(title, for: .normal)
    self.setTitleColor(titleColor, for: .normal)
    self.addTarget(self, action: #selector(didClickAction), for: .touchUpInside)
    self.tag = tag
    self.clickAction = clickAction
  }
  
  @objc func didClickAction() {
    clickAction(self.tag)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
