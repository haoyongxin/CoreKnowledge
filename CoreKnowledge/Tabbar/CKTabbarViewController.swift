//
//  CKTabbarViewController.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/3/8.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class CKTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.installSubViewController()
    }
  
    func installSubViewController() {
        let controls = ["KCThreadMainViewController","KCAnimationMainViewController","KCComponentMainViewController","KCOtherMainViewController"]
        let titles = ["线程","动画","UI","其他"]
        let images = ["thread_normal","animation_normal","ui_normal","other_normal"]
        let selectImages = ["thread_select","animation_select","ui_select","other_select"]
        var navArray = Array<UINavigationController>()
        let ns = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        for index in 0..<controls.count {
            let clsname = ns + "." + controls[index]
            guard let controller = NSClassFromString(clsname) as? UIViewController.Type else {
                return
            }
            let vc = controller.init()
            let tabbar = self.installTabarItem(title: titles[index], image: images[index], selectImage: selectImages[index])
            vc.tabBarItem = tabbar
//            vc.tabBarItem.title = titles[index]
//            vc.tabBarItem.selectedImage = UIImage(named: selectImages[index])
//            vc.tabBarItem.image = UIImage(named: images[index])
            let navigation = CKNavigationController(rootViewController: vc)
            navArray.append(navigation)
        }
        self.viewControllers = navArray
    }
  
    func installTabarItem(title: String?, image: String?, selectImage: String?) -> UITabBarItem {
        var normalImage: UIImage?
        var didSelectImage: UIImage?
        if let normal = image, !normal.isEmpty {
            normalImage = UIImage(named: normal)
        }
        if let select = selectImage, !select.isEmpty {
            didSelectImage = UIImage(named: select)
        }
        let tabbarItem = UITabBarItem(title: title, image: normalImage, selectedImage: didSelectImage)
//        tabbarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.black], for: .normal)
//        tabbarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.red], for: .selected)
        return tabbarItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
