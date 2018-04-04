//
//  KCOtherModel.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/4/3.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

enum OtherModelType {
  case AudioPlayback
}

class KCOtherModel: NSObject {
  var title: String?
  var imageName: String?
  var type: OtherModelType!
  
  init(title: String?, imageName: String?, type: OtherModelType) {
    self.title = title
    self.imageName = imageName
    self.type = type
  }
}
