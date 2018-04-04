//
//  KCModelCreator.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/4/3.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class KCModelCreator: NSObject {
  static var sharedInstall = KCModelCreator()
  
  func createAudioPlayback() -> KCOtherModel {
    let audioPlayback = KCOtherModel(title: "录音及播放", imageName: nil, type: .AudioPlayback)
    return audioPlayback
  }
  
  func otherModels() -> Array<KCOtherModel> {
    var modelArray = Array<KCOtherModel>()
    modelArray.append(createAudioPlayback())
    modelArray.append(createAudioPlayback())
    return modelArray
  }
  
}
