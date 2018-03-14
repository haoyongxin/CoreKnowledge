//
//  CKNavigationController.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/3/8.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class CKNavigationController: UINavigationController, UINavigationControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    self.delegate = self
  }
  
  override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
//    print("delegate:",self.interactivePopGestureRecognizer?.delegate as Any)
    self.interactivePopGestureRecognizer?.delegate = nil
    super.setNavigationBarHidden(hidden, animated: animated)
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    if viewControllers.count == 1 {
      viewController.hidesBottomBarWhenPushed = true
    }
    super.pushViewController(viewController, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: UINavigationControllerDelegate
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    print("willShow:",viewController)
    if viewController.isKind(of: KCThreadMainViewController.self) || viewController.isKind(of: SerialDispatchQueueViewController.self) || viewController.isKind(of: ConcurrentDispatchQueueViewController.self) {
      if !self.isNavigationBarHidden {
        navigationController.setNavigationBarHidden(true, animated: animated)
      }
    } else {
      if self.isNavigationBarHidden {
        navigationController.setNavigationBarHidden(false, animated: animated)
      }
    }
  }
  
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    print("didShow:",viewController)
  }
  
}
