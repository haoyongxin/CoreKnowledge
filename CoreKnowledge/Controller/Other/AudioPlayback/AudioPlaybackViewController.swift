//
//  AudioPlaybackViewController.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/4/3.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class AudioPlaybackViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "录音及播放音频"
    self.view.backgroundColor = UIColor.red
    let recordButton = UIButton(frame: CGRect(x: 10, y: 100, width: 100, height: 50))
    recordButton.setTitle("录音", for: .normal)
    recordButton.setTitleColor(UIColor.black, for: .normal)
    recordButton.setTitleColor(UIColor.lightGray, for: .highlighted)
    recordButton.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
    recordButton.tag = 100
    self.view.addSubview(recordButton)
    
    let playButton = UIButton(frame: CGRect(x: self.view.frame.width - 110, y: 100, width: 100, height: 50))
    playButton.setTitle("播放语音", for: .normal)
    playButton.setTitleColor(UIColor.black, for: .normal)
    playButton.setTitleColor(UIColor.lightGray, for: .highlighted)
    playButton.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
    playButton.tag = 200
    self.view.addSubview(playButton)
    
  }
  
  @objc func clickButton(button: UIButton) {
    switch button.tag {
    case 100:
      let recordVC = RecordingViewController()
      self.navigationController?.pushViewController(recordVC, animated: false)
      break
    case 200:
      let playVC = PlayRecordViewController()
      self.navigationController?.pushViewController(playVC, animated: true)
      break
    default:
      break
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
