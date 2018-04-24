//
//  CKNavigationController.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/3/8.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class CKNavigationController: UINavigationController, UINavigationControllerDelegate {
  var interactiveTransition: CKInteractiveTransition!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    self.navigationBar.isTranslucent = true
    self.delegate = self
//    print("interactivePopGestureRecognizer:",self.interactivePopGestureRecognizer as Any)
    self.interactivePopGestureRecognizer?.isEnabled = false
    self.interactiveTransition = CKInteractiveTransition(type: .Pop, viewController: self)
  }
  
  override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
    
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
//    print("willShow:",viewController)
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
//    print("didShow:",viewController)
  }
  
  func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactiveTransition.isInteration ? interactiveTransition : nil
  }
  
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if operation == .push {
      return CKViewControllerAnimatedTransitioning(type: .Push)
    } else if operation == .pop {
      return CKViewControllerAnimatedTransitioning(type: .Pop)
    } else {
      return CKViewControllerAnimatedTransitioning(type: .None)
    }
  }
  
}
