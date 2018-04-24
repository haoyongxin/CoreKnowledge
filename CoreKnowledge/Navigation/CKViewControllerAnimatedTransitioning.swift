//
//  CKViewControllerAnimatedTransitioning.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/4/8.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

enum AnimatedReansitioningType {
  case None
  case Pop
  case Push
}


class CKViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  var type = AnimatedReansitioningType.Push
  init(type: AnimatedReansitioningType) {
    self.type = type
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1.0
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    switch type {
    case .None:
      self.noneAnimatedTransitioning(transitionContext: transitionContext)
      break
    case .Pop:
      self.popAnimatedTransitioning(transitionContext: transitionContext)
      break
    case .Push:
      self.pushAnimatedTransitioning(transitionContext: transitionContext)
      break
    }
  }
  
  // MARK: 没有动画
  func noneAnimatedTransitioning(transitionContext: UIViewControllerContextTransitioning) {
    
  }
  // MARK: pop动画
  func popAnimatedTransitioning(transitionContext: UIViewControllerContextTransitioning) {
    if let fromVC = transitionContext.viewController(forKey: .from), let tabBarVC = fromVC.tabBarController {
      if let tabBarView = tabBarVC.view, let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to) {
        let containView = transitionContext.containerView
        let rect = transitionContext.initialFrame(for: fromVC)
        fromView.frame = rect
        containView.insertSubview(toView, belowSubview: fromView)
        tabBarView.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        let tabBar = tabBarVC.tabBar
        tabBar.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        UIView .animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
          tabBarView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
          tabBar.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
          fromView.frame = CGRect(x: rect.width, y: 0, width: rect.width, height: rect.height)
        }, completion: { (finished) in
          if finished {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
          }
        })
      }
    }
  }
  // MARK: push动画
  func pushAnimatedTransitioning(transitionContext: UIViewControllerContextTransitioning) {
    if let fromVC = transitionContext.viewController(forKey: .from), let tabBarVC = fromVC.tabBarController {
      if let fromView = tabBarVC.view, let toView = transitionContext.view(forKey: .to) {
        let containView = transitionContext.containerView
        let rect = transitionContext.initialFrame(for: fromVC)
        let toRect = CGRect(x: rect.width, y: 0, width: rect.width, height: rect.height)
        toView.frame = toRect
        containView.addSubview(toView)
        fromView.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        let tabBarView = tabBarVC.tabBar
        tabBarView.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
          fromView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
          tabBarView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
          toView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        }, completion: { (finished) in
          if finished {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
          }
        })
      }
    }
  }
  
  func animationEnded(_ transitionCompleted: Bool) {
    print("transitionCompleted:",transitionCompleted)
  }
  
}
