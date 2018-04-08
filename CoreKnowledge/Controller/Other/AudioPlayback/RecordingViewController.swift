//
//  RecordingViewController.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/4/2.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController {
  lazy var audioManager = AudioPlaybackManager.sharedInstance
  var recordButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "录音"
    self.view.backgroundColor = UIColor.yellow
    audioManager.delegate = self
    recordButton = UIButton(frame: CGRect(x: 100, y:self.view.frame.height - 150, width: self.view.frame.width - 200, height: 50))
    recordButton.setTitle("按住 说话", for: .normal)
    recordButton.setTitleColor(UIColor.black, for: .normal)
    recordButton.setTitleColor(UIColor.lightGray, for: .highlighted)
    recordButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
    recordButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    recordButton.addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
    recordButton.addTarget(self, action: #selector(touchDragEnter), for: .touchDragEnter)
    recordButton.addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
    recordButton.layer.cornerRadius = 10
    recordButton.layer.borderWidth = 1
    recordButton.layer.borderColor = UIColor.brown.cgColor
    self.view.addSubview(recordButton)
  }
  
  @objc func touchDown() {
    recordButton.setTitle("松开 结束", for: .normal)
    audioManager.startRecording()
    print("开始录音")
  }
  
  @objc func touchDragEnter() {
    recordButton.setTitle("松开 结束", for: .normal)
    audioManager.startRecording()
    print("手指从外部移进按钮 - 开始录音")
  }
  
  @objc func touchDragExit() {
    recordButton.setTitle("松开 取消", for: .normal)
    audioManager.pauseRecording()
    print("手指移除按钮 - 暂停录音")
  }
  
  @objc func touchUpInside() {
    recordButton.setTitle("按住 说话", for: .normal)
    audioManager.stopRecording()
    print("录音完成")
  }
  
  @objc func touchUpOutside() {
    recordButton.setTitle("按住 说话", for: .normal)
    let delete = audioManager.deleteRecording()
    if delete {
      print("删除录音文件成功")
    } else {
      print("删除录音文件失败")
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

extension RecordingViewController: AudioPlaybackManagerDelegate {
  func recordFinishWithUrl(url: String, isSuccess: Bool) {
    print("url:",url)
    audioManager.playAudioWithUrl(url: url)
  }
  
  func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
    print("error:",error as Any)
  }
}
