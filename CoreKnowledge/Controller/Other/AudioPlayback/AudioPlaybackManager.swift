//
//  AudioPlaybackManager.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/4/2.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol AudioPlaybackManagerDelegate {
  // MARK: 更新音量值
  @objc optional func updateVolumeMeters(value: CGFloat)
  // MARK: 录音错误
  @objc optional func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?)
  // MARK: 录音完成
  @objc optional func recordFinishWithUrl(url: String, isSuccess: Bool)
  
  // MARK: 播放音频完成
  @objc optional func audioPlayerDidFinishPlaying()
  // MARK: 播放音频失败
  @objc optional func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?)
}

class AudioPlaybackManager: NSObject {
  static var sharedInstance: AudioPlaybackManager = AudioPlaybackManager()
  var delegate: AudioPlaybackManagerDelegate?
  private var audioSession: AVAudioSession!
  private var audioPlay: AVAudioPlayer?
  private var audioRecorder: AVAudioRecorder?
  private var recordURL: URL!
  private var timer: Timer?
  override init() {
    super.init()
    audioSession = AVAudioSession.sharedInstance()
    audioRecorder = createRecorder()
  }
  // MARK:  --------------------> 录音 <-------------------------
  // MARK: 录音设置
  func recorderSettingConfig() -> NSMutableDictionary {
    let settingDic = NSMutableDictionary()
    // 录音参数设置
    // 设置录音格式
    settingDic.setValue(NSNumber.init(value: kAudioFormatLinearPCM), forKey: AVFormatIDKey)
    
    // 设置录音采样率（Hz）如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    settingDic.setValue(NSNumber.init(value: 8000), forKey: AVSampleRateKey)
    // 录音通道数  1 或 2
    settingDic.setValue(NSNumber.init(value: 1), forKey: AVNumberOfChannelsKey)
    // 线性采样位数  8、16、24、32
    settingDic.setValue(NSNumber.init(value: 16), forKey: AVLinearPCMBitDepthKey)
    // 录音的质量
    settingDic.setValue(NSNumber.init(value: AVAudioQuality.min.rawValue), forKey: AVEncoderAudioQualityKey)
    return settingDic
  }
  
  
  // MARK: 文件路径
  func getFilePath() -> URL? {
    guard let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last as NSString? else {
      return nil
    }
    let filePath = path.appendingPathComponent("AXQAudioFiles/AXQAudioRecord.caf")
    let fileManager = FileManager.default
    if !fileManager.fileExists(atPath: filePath) {
      let file = filePath as NSString
      do {
        try fileManager.createDirectory(atPath: file.deletingLastPathComponent, withIntermediateDirectories: true, attributes: nil)
        fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
      } catch {
        return nil
      }
    }
    return URL.init(fileURLWithPath: filePath)
  }
  
  // MARK: 录音
  func createRecorder() -> AVAudioRecorder? {
    if let filePath = self.getFilePath() {
      do {
        recordURL = filePath
        let audioRecorder = try AVAudioRecorder.init(url: filePath, settings: recorderSettingConfig() as! [String : Any])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        return audioRecorder
      } catch {
        return nil
      }
    }
    return nil
  }
  
  // MRAK: 开始录音
  func startRecording() {
    if let recorder = audioRecorder {
      if recorder.isRecording {
        return
      }
      self.setAudioSessionCategory(category: AVAudioSessionCategoryPlayAndRecord)
      recorder.record()
      self.createTimer()
    }
  }
  
  // MRAK: 暂停录音
  func pauseRecording() {
    if let recorder = audioRecorder {
      if recorder.isRecording {
        recorder.pause()
      }
    }
  }
  
  // MARK: 停止录音
  func stopRecording() {
    if let recorder = audioRecorder {
      if recorder.isRecording {
        recorder.stop()
      }
      timer?.invalidate()
      timer = nil
    }
  }
  
  // MARK: 删除录音
  func deleteRecording() -> Bool {
    timer?.invalidate()
    timer = nil
    if let recorder = audioRecorder {
      recorder.stop()
      return recorder.deleteRecording()
    }
    return false
  }
  
  // MARK: 设置AudioSession会话类别
  func setAudioSessionCategory(category: String) {
    try? audioSession.setCategory(category)
    try? audioSession.setActive(true)
  }
  
  // MARK: 创建倒计时
  func createTimer() {
    timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(volumeMeters(timer:)), userInfo: nil, repeats: true)
    RunLoop.main.add(timer!, forMode: .commonModes)
  }
  
  @objc func volumeMeters(timer: Timer) {
    audioRecorder?.updateMeters()
    var value = pow(10, (0.05 * (audioRecorder?.peakPower(forChannel: 0))!))
    if value < 0 {
      value = 0
    } else if value > 1 {
      value = 1
    }
    delegate?.updateVolumeMeters?(value: CGFloat(value))
  }
  
  // MARK: -----------------> 播放音频 <--------------------
  // MARK: 开始播放
  func playAudioWithUrl(url: String) {
    if url.isEmpty {
      return
    }
    self.stopPlaying()
    self.setAudioSessionCategory(category: AVAudioSessionCategoryPlayback)
    do {
      audioPlay = try AVAudioPlayer.init(contentsOf: URL.init(string: url)!)
      audioPlay?.prepareToPlay()
      audioPlay?.delegate = self
      audioPlay?.play()
    } catch let error {
      print("error:",error)
    }
  }
  
  // MARK: 停止播放
  func stopPlaying() {
    if let play = audioPlay {
      if play.isPlaying {
        play.stop()
      }
    }
  }
}

// MARK: - AVAudioRecorderDelegate 录音
extension AudioPlaybackManager: AVAudioRecorderDelegate {
  func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
    delegate?.audioRecorderEncodeErrorDidOccur?(recorder, error: error)
  }
  
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      try? audioSession.setActive(false)
      delegate?.recordFinishWithUrl?(url: recordURL.absoluteString, isSuccess: flag)
    }
  }
}

// MARK: - AVAudioPlayerDelegate 播放音频
extension AudioPlaybackManager: AVAudioPlayerDelegate {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    delegate?.audioPlayerDidFinishPlaying?()
  }
  
  func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
    delegate?.audioPlayerDecodeErrorDidOccur?(player, error: error)
  }
}
