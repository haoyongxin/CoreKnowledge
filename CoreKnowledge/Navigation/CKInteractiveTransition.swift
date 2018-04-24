//
//  CKInteractiveTransition.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/4/8.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

enum InteractiveTransitionType {
//  case Present
//  case Dismiss
//  case Push
  case Pop
}



class CKInteractiveTransition: UIPercentDrivenInteractiveTransition, UIGestureRecognizerDelegate {
  private var transitionType: InteractiveTransitionType!
  private var viewController: UIViewController!
  
  var isInteration = false
  
  init(type: InteractiveTransitionType, viewController: UIViewController) {
    super.init()
    self.transitionType = type
    self.viewController = viewController
    self.addPopGesture()
    print("duration:",duration)
  }
  
  func addPopGesture() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(pan:)))
    panGesture.delegate = self
    viewController.view.addGestureRecognizer(panGesture)
  }
  
  @objc func panGestureAction(pan: UIPanGestureRecognizer) {
    let state = pan.state
    if state == .began {
      self.isInteration = true
      guard let view = pan.view else {
        return
      }
      let translationPoint = pan.translation(in: view)
      if translationPoint.x > 0 {
        self.startGesture()
      }
    } else if state == .changed {
      guard let view = pan.view else {
        return
      }
      let translationPoint = pan.translation(in: view)
      if translationPoint.x > 0 {
        let persent = translationPoint.x / view.frame.width
        print("=====>.x:\(translationPoint.x), persent:\(persent)")
        self.update(persent)
      }
    } else {
      self.isInteration = false
      guard let view = pan.view else {
        return
      }
      let translationPoint = pan.translation(in: view)
      let persent = translationPoint.x / view.frame.width
      print("*******>.x:\(translationPoint.x), persent:\(persent)")
      if persent > 0.5 {
        self.finish()
      } else {
        self.cancel()
      }
    }
  }
  
  func startGesture() {
    switch self.transitionType {
//    case .Present:
//      break
//    case .Dismiss:
//      break
//    case .Push:
//      break
    case .Pop:
      if viewController.isKind(of: UINavigationController.self) {
        let nav = viewController as! UINavigationController
        nav.popViewController(animated: true)
      } else {
        self.viewController.navigationController?.popViewController(animated: true)
      }
      break
    default:
      break
    }
  }
  
}
